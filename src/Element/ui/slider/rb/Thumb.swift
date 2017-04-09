import Cocoa
@testable import Utils
/**
 * NOTE: This class is for the RBSliderList (RB = RubberBand)
 * NOTE: You might need to store the overshoot values for when you resize the button, could conflict if resize and progress changes at the same time, very edge case
 * NOTE: the overshot part is to support "the-RubberBand-list-look"
 * TODO: Rename this to RBThumb and override createThumb in vSlider instead, then revert this class to the simpler class
 */
class Thumb:Button{
    let fps:CGFloat = 60
    var duration:CGFloat?/*in seconds*/
    var framesToEnd:CGFloat?
    var currentFrameCount:CGFloat = 0
    var animator:Animator?
    //var isDisabled:Bool
    init(_ width: CGFloat, _ height: CGFloat, _ isDisabled:Bool = false ,_ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
        self.isDisabled = isDisabled
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    /**
     * This method facilitates the illusion that the sliderThumb overshoots. As apart of the rubberBand motion effect
     */
    func applyOvershot(_ progress:CGFloat, _ dir:Dir = .ver){
        if(progress < 0){/*top overshot*/
            let size:CGSize = dir == .ver ? CGSize(width, height-(height*progress.positive)) : CGSize(width - (width*progress.positive),height)
            self.skin!.setSize(size.width,size.height)
        }else if(progress > 1){/*bottom overshot*/
            let overshot = self.size[dir] * (progress-1)
            let size:CGSize = dir == .ver ? CGSize() : CGSize()
            self.skin!.setSize(width, height - overshot)
            (self.skin! as! Skin).frame.y = overshot
        }
    }
    //TODO: these overrides are not needed, just add a disbaled state to the css that has alpha set to 0
    override func mouseOver(_ event:MouseEvent) {if(!isDisabled){super.mouseOver(event)}}
    override func mouseOut(_ event:MouseEvent) {if(!isDisabled){super.mouseOut(event)}}
    override func mouseDown(_ event:MouseEvent) {if(!isDisabled){super.mouseDown(event)}}
    override func mouseUp(_ event:MouseEvent) {if(!isDisabled){super.mouseUp(event)}}
    override func mouseUpOutside(_ event:MouseEvent) {if(!isDisabled){super.mouseUpOutside(event)}}
    override func mouseUpInside(_ event:MouseEvent) {if(!isDisabled){super.mouseUpOutside(event)}}
    override func getSkinState() -> String {//may not work
        var state:String = ""
        if(isDisabled) {state += SkinStates.disabled + " "}
        return state + super.getSkinState()
    }
    /**
     * Sets the _isDisabled variable (Toggles between two states)
     */
    func setDisabled(_ isDisabled:Bool) {
        self.isDisabled = isDisabled
        super.setSkinState(getSkinState())
        //TODO: Set button mode to not hand here
    }
    override func getClassType() -> String {
        return "\(Button.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension Thumb{
    var alpha:CGFloat{/*Convenience*/
        get{
            return self.skin!.decoratables[0].getGraphic().fillStyle!.color.alphaComponent
        }set{
            self.skin?.decoratables[0].getGraphic().fillStyle!.color = (self.skin?.decoratables[0].getGraphic().fillStyle!.color.alpha(newValue))!
        }
    }
    /**
     * Animator method that interpolates the alpha between 0 and 1
     */
    func interpolateAlpha(_ val:CGFloat){
        //Swift.print("interpolateAlpha()")
        alpha = val
        self.skin?.decoratables[0].draw()
    }
    /**
     * Call this when you want to fade-in the thumb
     */
    func fadeIn(){
        //Swift.print("Thumb.fadeIn")
        //let rbSliderListRef = self.superview?.superview as! RBSliderList
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.2,alpha,1,interpolateAlpha,Sine.easeOut)
        animator!.event = {(event:Event) -> Void in }
        animator!.start()
    }
    /**
     * Call this when you want to fade-out the thumb
     */
    func fadeOut(){
        //Swift.print("Thumb.fadeOut")
        //let rbSliderListRef = self.superview?.superview as! RBSliderList
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,alpha,0,interpolateAlpha,Quad.easeIn)
        animator!.event = {(event:Event) -> Void in }
        animator!.start()
    }
}
