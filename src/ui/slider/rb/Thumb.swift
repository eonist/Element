import Cocoa

/**
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
}
