import Cocoa

class GradientSlider:HNodeSlider{
    var gradient : IGradient?
    init(_ width : CGFloat = NaN, _ height : CGFloat = NaN, _ nodeWidth : CGFloat = NaN, _ gradient:IGradient? = nil, _ startProgress : CGFloat = 0, _ endProgress : CGFloat = 1, _ parent : IElement? = nil, _ id : String = "") {
        super.init(width, height, nodeWidth, startProgress, endProgress, parent, id)
        setGradient(gradient!)
    }
    func setGradient(gradient:IGradient){
        //print("setGradient"+gradient.colors)
        self.gradient = gradient
        //print("_gradient: " + _gradient)
        let style:IStyle = StyleModifier.clone(skin!.style!,skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var styleProperty = style.getStyleProperty("fill",0) /*edits the style*/
        //Swift.print("styleProperty: " + "\(styleProperty)")
        //Swift.print("color.hex: " + "\(color.hexString)")
        if(styleProperty != nil){//temp
            //Swift.print("styleProperty!.value: ")
            styleProperty!.value = gradient/*edits the style*/
            skin!.setStyle(style)/*updates the skin*/
        }
        //skin.setState(SkinStates.NONE)/*update the skin*/
        skin!.setStyle(style)/*updates the skin*/
    }
    override func onStartNodeMove(event:NSEvent)-> NSEvent? {
        Swift.print("GradientSlider.onStartNodeMove() ")
        let ratio:CGFloat = startProgress//round(/* * 255*/)
        //Swift.print("ratio: " + "\(ratio)")
        gradient!.locations = [ratio,gradient!.locations[1]]
        setGradient(gradient!)
        return super.onStartNodeMove(event);
    }
    override func onEndNodeMove(event:NSEvent)-> NSEvent? {
        Swift.print("GradientSlider.onEndNodeMove() ")
        let ratio:CGFloat = endProgress//round( * 255)
        //Swift.print("ratio: " + "\(ratio)")
        gradient!.locations = [gradient!.locations[0],ratio]
        setGradient(gradient!)
        return super.onEndNodeMove(event)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}