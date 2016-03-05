import Cocoa

/**
 * NOTE: You might need to store the overshoot values for when you resize the button, could conflict if resize and progress changes at the same time, very edge case
 */
class Thumb:Button{
    override func getClassType() -> String {
        return String(Button)
    }
    /**
     * This method facilitates the illusion that the sliderThumb overshoots. As apart of the rubberBand effect
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
    
    
    //Continue here: 
    //animate from value to value with: duration and custom property or adhock arg method that you can set your self
    //should have 2 custom transition types: easeIn and easeOut (use log10 or regular easing multiplier, see book for this)
    //you should have a finished call-back method
    
    /**
     *
     */
    func animate(seconds:CGFloat){
        //CVDisplayLinkIsRunning
        CVDisplayLinkStart(displayLink)
        
    }
}
