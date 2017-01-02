import Cocoa
/**
 * NOTE: This class is for the RBSliderList (RB = RubberBand)
 * NOTE: You might need to store the overshoot values for when you resize the button, could conflict if resize and progress changes at the same time, very edge case
 * NOTE: the overshot part is to support "the-RubberBand-list-look"
 */
class Thumb:Button{
    let fps:CGFloat = 60
    var duration:CGFloat?/*in seconds*/
    var framesToEnd:CGFloat?
    var currentFrameCount:CGFloat = 0
    var animator:Animator?
    var isDisabled:Bool
    init(_ width: CGFloat, _ height: CGFloat, _ isDisabled:Bool = false ,_ parent: IElement? = nil, _ id: String? = nil) {
        self.isDisabled = isDisabled
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    /**
     * This method facilitates the illusion that the sliderThumb overshoots. As apart of the rubberBand motion effect
     */
    func applyOvershot(progress:CGFloat){
        //Swift.print("applyOvershot.start")
        if(progress < 0){/*top overshot*/
            self.skin!.setSize(width, height-(height*abs(progress)))
        }else if(progress > 1){/*bottom overshot*/
            let overshot = height*(progress-1)
            self.skin!.setSize(width, height - overshot)
            (self.skin! as! Skin).frame.y = overshot
        }
        //Swift.print("applyOvershot.end")
    }
    //continue here:🏀
        //these overrides are not needed, just add a disbaled state to the css that has alpha set to 0
    override func mouseOver(event: MouseEvent) {
        if(!isDisabled){
            super.mouseOver(event)
        }
    }
    override func mouseOut(event: MouseEvent) {
        if(!isDisabled){
            super.mouseOut(event)
        }
    }
    override func mouseDown(event: MouseEvent) {
        if(!isDisabled){
            super.mouseDown(event)
        }
    }
    override func mouseUp(event: MouseEvent) {
        if(!isDisabled){
            super.mouseUp(event)
        }
    }
    override func mouseUpOutside(event: MouseEvent) {
        if(!isDisabled){
            super.mouseUpOutside(event)
        }
    }
    override func mouseUpInside(event: MouseEvent) {
        if(!isDisabled){
            super.mouseUpOutside(event)
        }
    }
    override func getSkinState() -> String {//may not work
        var state:String = ""
        if(isDisabled) {state += SkinStates.disabled + " "}
        return state + super.getSkinState()
    }
    /**
     * Sets the _isDisabled variable (Toggles between two states)
     */
    func setDisabled(isDisabled:Bool) {
        self.isDisabled = isDisabled
        super.setSkinState(getSkinState())
        //set button mode to not hand here
    }
    override func getClassType() -> String {
        return String(Button)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
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
    func interpolateAlpha(val:CGFloat){
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
        animator = Animator(Animation.sharedInstance,0.2,alpha,1,interpolateAlpha,Easing.easeOutSine)
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
        animator = Animator(Animation.sharedInstance,0.5,alpha,0,interpolateAlpha,Easing.easeInQuad)
        animator!.event = {(event:Event) -> Void in }
        animator!.start()
    }
}