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
 * TODO: You can store the active animator instance count in the AnimatableView to know when to stop the cvdisplaylink
 * TODO: take a look at other animation libs
 * TODO: Add onComplete selector callback method on init and as a variable, do the same with method, use optional to assert if they exist or not
 * TODO: seek,reverse,repeate,autoRepeat
 */
class Animator{
    let fps:CGFloat = 60//this should be pulled from a device variable
    var view:AnimatableView
    var duration:CGFloat/*in seconds*/
    var from:CGFloat
    var to:CGFloat
    var method:(CGFloat)->Void
    var framesToEnd:CGFloat?//totFrameCount
    var currentFrameCount:CGFloat = 0//curFrameCount
    //isActive used by the AnimatiableView to assert if an animator is active or not
    init(_ view:AnimatableView, _ duration:CGFloat = 0.5, _ from:CGFloat, _ to:CGFloat, _ method:(CGFloat)->Void){
        self.view = view
        self.duration = duration
        self.from = from
        self.to = to
        self.method = method
    }
    /**
     *
     */
    func onFrame(){
        let val:CGFloat = NumberParser.interpolate(from, to, currentFrameCount / framesToEnd!)//interpolates the value
        method(val)//call the property method
        if(currentFrameCount == framesToEnd){
            Swift.print("end of anim")/*when the count becomes 0 the frame ticker stops*/
            view.animators.remo
        }
        self.currentFrameCount++
        //call the method here
        //the method should be posible to be created as a inline method closure
    }
    /**
     *
     */
    func start(){
        view.animators.append(self)
    }
    //start
    //stop
    //pause
    //remove
}