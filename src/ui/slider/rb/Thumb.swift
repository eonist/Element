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
    
    override func getClassType() -> String {
        return String(Button)
    }
    /**
     * This method facilitates the illusion that the sliderThumb overshoots. As apart of the rubberBand motion effect
     */
    func applyOvershot(progress:CGFloat){
        if(progress < 0){//top overshot
            self.skin!.setSize(width, height-(height*abs(progress)))
        }else if(progress > 1){//bottom overshot
            let overshot = height*(progress-1)
            self.skin!.setSize(width, height - overshot)
            (self.skin! as! Skin).frame.y = overshot
        }
    }
    func fadeIn(){
        let animator = Animator(thumb,0.5,1,0,interpolateAlpha,Easing.easeInOutQuad)
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("click")
                animator.start()
            }
        }
        thumb.event = onEvent
    }
    func fadeOut(){
        
    }
}