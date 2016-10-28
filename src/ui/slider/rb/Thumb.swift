import Cocoa
/**
 * NOTE: This class is for the RBSliderList (RB = RubberBand)
 * NOTE: You might need to store the overshoot values for when you resize the button, could conflict if resize and progress changes at the same time, very edge case
 */
class Thumb:Button{
    let fps:CGFloat = 60
    var duration:CGFloat?/*in seconds*/
    var framesToEnd:CGFloat?
    var currentFrameCount:CGFloat = 0
    var animator:Animator?
    override func resolveSkin() {
        super.resolveSkin()
    }
    override func getClassType() -> String {
        return String(Button)
    }
    /**
     * This method facilitates the illusion that the sliderThumb overshoots. As apart of the rubberBand motion effect
     */
    func applyOvershot(progress:CGFloat){
        //Swift.print("applyOvershot.start")
        if(progress < 0){//top overshot
            self.skin!.setSize(width, height-(height*abs(progress)))
        }else if(progress > 1){//bottom overshot
            let overshot = height*(progress-1)
            self.skin!.setSize(width, height - overshot)
            (self.skin! as! Skin).frame.y = overshot
        }
        //Swift.print("applyOvershot.end")
    }  
}
extension Thumb{
    func interpolateAlpha(val:CGFloat){
        //Swift.print("interpolateAlpha()")
        self.skin?.decoratables[0].getGraphic().fillStyle?.color = (self.skin?.decoratables[0].getGraphic().fillStyle?.color.alpha(val))!
        self.skin?.decoratables[0].draw()
    }
    func fadeIn(){
        //Swift.print("Thumb.fadeIn")
        //let rbSliderListRef = self.superview?.superview as! RBSliderList
        if(animator != nil){animator!.stop()}//stop any previous running animation
        let curVal:CGFloat = self.skin!.decoratables[0].getGraphic().fillStyle!.color.alphaComponent
        animator = Animator(Animation.sharedInstance,0.2,curVal,1,interpolateAlpha,Easing.easeOutSine)
        animator!.event = {(event:Event) -> Void in }
        animator!.start()
    }
    func fadeOut(){
        //Swift.print("Thumb.fadeOut")
        //let rbSliderListRef = self.superview?.superview as! RBSliderList
        if(animator != nil){animator!.stop()}//stop any previous running animation
        let curVal:CGFloat = self.skin!.decoratables[0].getGraphic().fillStyle!.color.alphaComponent
        animator = Animator(Animation.sharedInstance,0.5,curVal,0,interpolateAlpha,Easing.easeInQuad)
        animator!.start()
    }
}