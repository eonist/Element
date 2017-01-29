import Foundation
@testable import Utils

//Continue here: 
    //add the third layer with the same style as SwitchThumb
    //try to move it onMouseMove
    //keep adding interaction + anim code from Switch1

class Switch2:SwitchSlider,ICheckable{
    var thumbAnimator:Animator?
    var progressAnimator:Animator?
    var bgColorAnimator:Animator?
    var bgProgressAnimator:Animator?
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
        
        /*bg Anim*/
        if(bgColorAnimator != nil){bgColorAnimator!.stop()}
        bgColorAnimator = Animator(Animation.sharedInstance,0.4,0,1,bgColorAnim,Linear.ease)/*from 0 to 1*/
        bgColorAnimator!.start()
        
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
        /*Bg Anim*/
        if(!isChecked){//must be in off state
            if(bgColorAnimator != nil){bgColorAnimator!.stop()}
            bgColorAnimator = Animator(Animation.sharedInstance,0.4,1,0,bgColorAnim,Linear.ease)/*from 1 to 0*/
            bgColorAnimator!.start()
        }
        super.mouseUp(event)
    }
    func setChecked(_ isChecked:Bool) {
        Swift.print("setChecked: " + "\(isChecked)")
        if(progressAnimator != nil){progressAnimator!.stop()}
        if(bgProgressAnimator != nil){bgProgressAnimator!.stop()}
        if(self.isChecked && !isChecked){
            progressAnimator = Animator(Animation.sharedInstance,0.5,1,0,progressAnim,Back.easeOut)/*Animate setProgress from 1 - 0*/
            bgProgressAnimator = Animator(Animation.sharedInstance,0.2,1,0,bgProgressAnim,Quad.easeOut)/*Animate setProgress from 1 - 0*/
        }else if (!self.isChecked && isChecked){
            progressAnimator = Animator(Animation.sharedInstance,0.5,0,1,progressAnim,Back.easeOut)/*Animate setProgress from 0 - 1*/
            bgProgressAnimator = Animator(Animation.sharedInstance,0.3,0,1,bgProgressAnim,Quad.easeOut)/*Animate setProgress from 0 - 1*/
        }
        bgProgressAnimator!.start()
        progressAnimator!.start()
        self.isChecked = isChecked
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
        progress = value
        let style:IStyle = skin!.style!
        var offsetProp = skin!.style!.getStyleProperty("offset",2)
        let thumbWidth:CGFloat = 100//thumbWidth is always 100
        let thumbX = HSliderUtils.thumbPosition(progress, width, thumbWidth)
        offsetProp!.value = [thumbX, 0]
        
        /*ThumbLine*/
        var thumbLineProp = style.getStyleProperty("line",2) /*edits the style*/
        if(thumbLineProp != nil){//temp
            let color:NSColor = grey.blended(withFraction: value, of: green)!
            thumbLineProp!.value = color
        }
        
        skin!.setStyle(style)
    }
    func thumbAnim(value:CGFloat){
        //Swift.print("thumbAnim: " + "\(value)")
        let style:IStyle = skin!.style!//StyleModifier.clone(thumb!.skin!.style!, thumb!.skin!.style!.name)
        var marginProp = style.getStyleProperty("margin-left",2) /*edits the style*/
        marginProp!.value = getChecked() ? 20 * (1-value) : 0
        var widthProp = style.getStyleProperty("width",2)
        widthProp!.value = 80 + (20 * value)
        //Swift.print("thumbStyleProperty!.value: " + "\(thumbStyleProperty!.value)")
        skin!.setStyle(style)
    }
    func bgColorAnim(value:CGFloat){
        Swift.print("bgColorAnim: " + "\(value)")
        
        let style:IStyle = StyleModifier.clone(skin!.style!,skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var fillProp = style.getStyleProperty("fill",1) /*edits the style*/
        //let curColor:NSColor = fillProp!.value as! NSColor
        if(getChecked()){
            Swift.print("initColor : grey")
            Swift.print("endColor : grey")
        }else{
            Swift.print("initColor : white")
            Swift.print("endColor : grey")
        }
        let initColor = getChecked() ? grey : white
        let endColor = getChecked() ? white : grey
        let offColor = initColor.blended(withFraction: value, of: endColor)!
        fillProp!.value = offColor
        
        skin!.setStyle(style)
    }
    func bgProgressAnim(value:CGFloat){
        //interpolateColor(value)
    }
}
extension Switch2{
    var green:NSColor {return NSColorParser.nsColor(UInt(0x39D149))}
    var grey:NSColor {return NSColorParser.nsColor(UInt(0xDCDCDC))}
    var white:NSColor {return NSColor.white}
}
extension Switch2{
    var initW:CGFloat = {return 140}
    //let endW:CGFloat = 140 - 80
    var initH:CGFloat = {return 80}
    var initFillet:CGFloat = {return 40}
    var initOffsetX:CGFloat = {return 140/2}
    var initOffsetY:CGFloat = {return 80/2}
}
