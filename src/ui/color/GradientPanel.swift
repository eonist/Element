import Cocoa

class GradientPanel:Element,IGradientPanel{
    var gradientSlider:GradientSlider?
    var colorInput:ColorInput?
    var alphaSpinner:LeverSpinner?
    var ratioSpinner:LeverSpinner?
    var itemHeight:CGFloat
    var gradient:IGradient
    var gradientTypeSelectGroup:SelectGroup?
    var focalPointRatioSpinner:LeverSpinner?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ gradient:IGradient? = nil, _ parent:IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight
        self.gradient = gradient!
        super.init(width, height, parent, id)
    }
    override func resolveSkin(){
        super.resolveSkin()
        let linearRadioButton = addSubView(RadioButton(NaN,NaN,"Linear",true,self))
        let radialRadioButton = addSubView(RadioButton(NaN,NaN,"Radial",false,self))
        gradientTypeSelectGroup = SelectGroup([linearRadioButton,radialRadioButton],linearRadioButton)
        gradientTypeSelectGroup!.event = onEvent/*attach the selectGroup to self, to handle the events here*/
        gradientSlider = addSubView(GradientSlider(width,12/*<--this should be NaN*/,20/*<--this should be NaN*/,gradient,0,1,self))
        let nsColor:NSColor = gradientSlider!.gradient!.colors[0].nsColor
        colorInput = addSubView(ColorInput(width,NaN,"Color:",nsColor,self))
        alphaSpinner = addSubView(LeverSpinner(width, NaN,"Alpha:",1,0.01,0,1,2,1,200,self))
        ratioSpinner = addSubView(LeverSpinner(width, NaN,"Ratio:",1,1,0,255,1,100,200,self))
        focalPointRatioSpinner = addSubView(LeverSpinner(width, NaN,"Focal point:",0,0.01,-1,1,2,100,200,self))
    }
    private func onGradientSliderChange(event : NodeSliderEvent) {
        Swift.print("GradientPanel.onGradientSliderChange()")
        let isStartNodeSelected:Bool = event.selected === gradientSlider!.startNode
        let ratio:CGFloat = isStartNodeSelected ? event.startProgress : event.endProgress
        Swift.print("ratio: " + "\(ratio)")
        ratioSpinner!.setValue(ratio/*round( * 255)*/)
    }
    private func onGradientSliderSelectGroupChange(event : SelectGroupEvent) {
        let index:Int = event.selectable === gradientSlider!.startNode ? 0 : 1
        Swift.print("index: " + "\(index)");
        Swift.print("gradientSlider.gradient.colors: " + "\(gradientSlider!.gradient!.colors)")
        let nsColor:NSColor = gradientSlider!.gradient!.colors[index].nsColor
        colorInput!.setColorValue(nsColor)
        ColorSync.receiver = colorInput
        ColorSync.setColor(nsColor)
        alphaSpinner!.setValue(gradientSlider!.gradient!.colors[index].nsColor.alphaComponent)
        ratioSpinner!.setValue(gradientSlider!.gradient!.locations[index])
    }
    private func onAlphaSpinnerChange(event:SpinnerEvent){
        Swift.print("onAlphaSpinnerChange()")
        let isStartNodeSelected:Bool = gradientSlider!.selectGroup!.selected === gradientSlider!.startNode
        let alpha1:CGFloat = isStartNodeSelected ? event.value : gradientSlider!.gradient!.colors[0].nsColor.alphaComponent
        let alpha2:CGFloat = !isStartNodeSelected ? event.value : gradientSlider!.gradient!.colors[1].nsColor.alphaComponent
        gradientSlider!.gradient!.colors[0] = gradientSlider!.gradient!.colors[0].alpha(alpha1)
        gradientSlider!.gradient!.colors[1] = gradientSlider!.gradient!.colors[1].alpha(alpha2)
    }
    private func onRatioSpinnerChange(event:SpinnerEvent) {
        Swift.print("onRatioSpinnerChange()")
        let isStartNodeSelected:Bool = gradientSlider!.selectGroup!.selected === gradientSlider!.startNode
        let ratio1:CGFloat = isStartNodeSelected ? event.value : gradientSlider!.gradient!.locations[0]
        let ratio2:CGFloat = !isStartNodeSelected ? event.value : gradientSlider!.gradient!.locations[1]
        gradientSlider!.gradient!.locations[0] = ratio1
        gradientSlider!.gradient!.locations[1] = ratio2
        if(isStartNodeSelected){gradientSlider!.setStartProgressValue(event.value/255)}
        else{gradientSlider!.setEndProgressValue(event.value/255)}
    }
    private func onFocalPointRatioSpinnerChange(event:SpinnerEvent){
        //gradient.focalPointRatio = event.value;// :TODO: test this!
    }
    /**
     * //TODO:remember to add alpha into the fold here
     */
    private func onColorInputChange(event : ColorInputEvent) {
        Swift.print("onColorInputChange() ");
        
        Swift.print(SelectGroupParser.selected(gradientSlider!.selectGroup!))
        let isStartNodeSelected:Bool = /*SelectGroupParser.selected(gradientSlider!.selectGroup!)*/gradientSlider!.selectGroup!.selected === gradientSlider!.startNode
        Swift.print("isStartNodeSelected: " + "\(isStartNodeSelected)")
        let color1:CGColorRef = isStartNodeSelected ? event.color.cgColor : gradientSlider!.gradient!.colors[0]
        //Swift.print("color1: " + color1)
        let color2:CGColorRef = !isStartNodeSelected ? event.color.cgColor : gradientSlider!.gradient!.colors[1]
        //Swift.print("color2: " + color2)
        gradientSlider!.gradient!.colors[0] = color1
        gradientSlider!.gradient!.colors[1] = color2
        gradientSlider!.setGradient(gradientSlider!.gradient!)
    }
    private func onGradientTypeSelectGroupChange(event:SelectGroupEvent){
        if((event.selectable as! TextButton).getText() == "Linear"){
            Swift.print("Linear ");
        }else{
            Swift.print("Radial ");
        }
    }
    override func onEvent(event: Event) {
        
        if(event.type == NodeSliderEvent.change && event.origin === gradientSlider){onGradientSliderChange(event as! NodeSliderEvent)}
        if(event.type == SelectGroupEvent.change && event.origin === gradientSlider!.selectGroup){onGradientSliderSelectGroupChange(event as! SelectGroupEvent)}
        if(event.type == SpinnerEvent.change && event.origin === alphaSpinner){onAlphaSpinnerChange(event as! SpinnerEvent)}
        if(event.type == SpinnerEvent.change && event.origin === focalPointRatioSpinner){onFocalPointRatioSpinnerChange(event as! SpinnerEvent)}
        if(event.type == ColorInputEvent.change && event.origin === colorInput){onColorInputChange(event as! ColorInputEvent)}
        if(event.type == SelectGroupEvent.change && event.origin === gradientTypeSelectGroup){onGradientTypeSelectGroupChange(event as! SelectGroupEvent)}
        /**/
    }
    /**
     * @Note you can set matrix to nil in the @param gradient
     */
    func setGradient(var gradient:IGradient){
        gradientSlider!.setGradient(gradient)
        let index:Int = gradientSlider!.selectGroup!.selected === gradientSlider!.startNode ? 0 : 1
        alphaSpinner!.setValue(gradient.colors[index].nsColor.alphaComponent)
        ratioSpinner!.setValue(gradient.locations[index])
        self.gradient = gradient
    }
    /**
     *
     */
    func setColor(color:NSColor){
        let isStartNodeSelected:Bool = gradientSlider!.selectGroup!.selected === gradientSlider!.startNode
        let color1:NSColor = isStartNodeSelected ? color : gradientSlider!.gradient!.colors[0].nsColor
        let color2:NSColor = !isStartNodeSelected ? color : gradientSlider!.gradient!.colors[1].nsColor
        //Swift.print("color2: " + color2)
        gradientSlider!.gradient!.colors[0] = color1.cgColor
        gradientSlider!.gradient!.colors[1] = color2.cgColor
    }
    override func setSize(width : CGFloat, _ height : CGFloat) {
        super.setSize(width, height)
        ElementModifier.refresh(self)
        gradientSlider!.setSize(width, StylePropertyParser.height(gradientSlider!.skin!)!)
    }
    /**
     * Returns "GradientPanel"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType() -> String {
        return String(GradientPanel)
    }
    var color:NSColor {
        let index:Int = gradientSlider!.selectGroup!.selected === gradientSlider!.startNode ? 0 : 1
        return gradientSlider!.gradient!.colors[index].nsColor
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}