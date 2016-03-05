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
    
    
    //Continue here: 
    //animate from value to value with: duration and custom property or adhock arg method that you can set your self
    //should have 2 custom transition types: easeIn and easeOut (use log10 or regular easing multiplier, see book for this)
    //you should have a finished call-back method
    //you should probably make a class that holds the animation variables etc. and hooks into the displayLink, Similar to RBScrollController, call it Animator.swift
    
    /**
     *
     */
    func animate(duration:CGFloat){
        //
        framesToEnd = fps * duration
        Swift.print("beginning of anim")
        CVDisplayLinkStart(displayLink)
        
    }
    let from:CGFloat = 0
    let to:CGFloat = 1
    override func onFrame() {
        let val:CGFloat = NumberParser.interpolate(from, to, currentFrameCount / framesToEnd!)
        //Swift.print("val: " + "\(val)")
        skin?.decoratables[0].getGraphic().fillStyle?.color = (skin?.decoratables[0].getGraphic().fillStyle?.color.alpha(val))!
        skin?.decoratables[0].draw()
        if(currentFrameCount == framesToEnd){
            Swift.print("end of anim")
            if(CVDisplayLinkIsRunning(displayLink)){
                CVDisplayLinkStop(displayLink)
            }
        }
        self.currentFrameCount++
        super.onFrame()
    }
}
/**
 * You can store the active animator instance count in the AnimatableView
 */
class Animator{
    let fps:CGFloat = 60
    var duration:CGFloat?/*in seconds*/
    var framesToEnd:CGFloat?
    var currentFrameCount:CGFloat = 0
    init(){
        
    }
}