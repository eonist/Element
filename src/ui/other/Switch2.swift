import Foundation
@testable import Utils

//Continue here: 
    //add the third layer with the same style as SwitchThumb
    //try to move it onMouseMove
    //keep adding interaction + anim code from Switch1

class Switch2:SwitchSlider,ICheckable{
    var thumbAnimator:Animator?
    var progressAnimator:Animator?
    private var isChecked:Bool
    init(_ width:CGFloat, _ height:CGFloat, _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String? = nil, _ classId:String? = nil) {
        self.isChecked = isChecked
        super.init(width,height,isChecked ? 1:0,parent,id)
    }
    
    override func onMouseMove(event:NSEvent)-> NSEvent?{
        let event = super.onMouseMove(event:event)
        
        if(progress == 1 && !isChecked){
            setChecked(true)
            //disableMouseUp = true
        }else if(progress == 0 && isChecked){
            setChecked(false)
            //disableMouseUp = true
        }
        return event
    }
    override func mouseDown(_ event:MouseEvent) {
        Swift.print("Switch2.mouseDown isChecked: \(isChecked)")
        let style:IStyle = self.skin!.style!//StyleModifier.clone(thumb!.skin!.style!, thumb!.skin!.style!.name)
        var widthProp = style.getStyleProperty("width",2)
        widthProp!.value = 80
        var marginProp = style.getStyleProperty("margin-left",2) /*edits the style*/
        marginProp!.value = progress == 1 ? 20  : 0
        self.skin!.setStyle(style)/*updates the skin*/
        
        /*Thumb Anim*/
        if(thumbAnimator != nil){thumbAnimator!.stop()}
        thumbAnimator = Animator(Animation.sharedInstance,0.2,0,1,thumbAnim,Linear.ease)/*from 0 to 1*/
        thumbAnimator!.start()
        
        super.mouseDown(event)
    }
    override func mouseUpInside(_ event: MouseEvent) {
        Swift.print("Switch2.mouseUpInside")
        super.mouseUpInside(event)
    }
    override func mouseUpOutside(_ event: MouseEvent) {
        Swift.print("Switch2.mouseUpOutside")
        super.mouseUpOutside(event)
    }
    override func mouseUp(_ event: MouseEvent) {
        /*Thumb Anim*/
        if(thumbAnimator != nil){thumbAnimator!.stop()}
        thumbAnimator = Animator(Animation.sharedInstance,0.2,1,0,thumbAnim,Linear.ease)/*from 1 to 0*/
        thumbAnimator!.start()
        
        super.mouseUp(event)
    }
    func setChecked(_ isChecked:Bool) {
        Swift.print("setChecked: " + "\(isChecked)")
        self.isChecked = isChecked
        if(progressAnimator != nil){progressAnimator!.stop()}
        
        if(self.isChecked && !isChecked){
            progressAnimator = Animator(Animation.sharedInstance,0.5,1,0,progressAnim,Back.easeOut)/*Animate setProgress from 1 - 0*/
            
        }else if (!self.isChecked && isChecked){
            progressAnimator = Animator(Animation.sharedInstance,0.5,0,1,progressAnim,Back.easeOut)/*Animate setProgress from 0 - 1*/
            
        }
        progressAnimator!.start()
        
        //setSkinState(getSkinState())
    }
    override func getClassType() -> String {
        return "\(Switch.self)"
    }
    func getChecked() -> Bool {
        return isChecked
    }
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState()
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * We have the animation stuff in an extension to make the code becomes more modular
 */
extension Switch2{
    func progressAnim(value:CGFloat){
        //Swift.print("progressAnim.value: " + "\(value)")
        self.progress = progress
        var offsetProp = skin!.style!.getStyleProperty("offset",2)//center align the scaling of the white bg graphic
        let thumbWidth = 100
        let thumbX = HSliderUtils.thumbPosition(self.progress, width, thumbWidth)
        offsetProp!.value = [thumbX, 0]
        
    }
    func thumbAnim(value:CGFloat){
        //Swift.print("thumbAnim: " + "\(value)")
        let style:IStyle = self.skin!.style!//StyleModifier.clone(thumb!.skin!.style!, thumb!.skin!.style!.name)
        var marginProp = style.getStyleProperty("margin-left",2) /*edits the style*/
        marginProp!.value = getChecked() ? 20 * (1-value) : 0
        var widthProp = style.getStyleProperty("width",2)
        widthProp!.value = 80 + (20 * value)
        //Swift.print("thumbStyleProperty!.value: " + "\(thumbStyleProperty!.value)")
        self.skin!.setStyle(style)
    }
}
