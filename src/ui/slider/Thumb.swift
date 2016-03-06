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
/**
 * TODO: You can store the active animator instance count in the AnimatableView to know when to stop the cvdisplaylink
 * TODO: take a look at other animation libs
 * TODO: Add onComplete selector callback method on init and as a variable, do the same with method, use optional to assert if they exist or not
 * TODO: seek,reverse,repeate,autoRepeat
 */
class Animator{
    let fps:CGFloat = 60//this should be pulled from a device variable
    var view:AnimatableView//ref to where the displayLink recides
    var duration:CGFloat/*in seconds*/
    var from:CGFloat//from this value
    var to:CGFloat//to this value
    var method:(CGFloat)->Void//the closure method that changes the property
    var framesToEnd:CGFloat//totFrameCount
    var currentFrameCount:CGFloat = 0//curFrameCount
    var val:CGFloat
    //isActive used by the AnimatiableView to assert if an animator is active or not
    init(_ view:AnimatableView, _ duration:CGFloat = 0.5, _ from:CGFloat, _ to:CGFloat, _ method:(CGFloat)->Void){
        self.view = view
        self.duration = duration
        self.from = from
        self.to = to
        self.method = method
        framesToEnd = fps * duration
        val = from
    }
    /**
     * Fires on every frame tick
     */
    func onFrame(){
        Swift.print("onFrame()")
        //var val:CGFloat = NumberParser.interpolate(from, to, currentFrameCount / framesToEnd)//interpolates the value
        val = Easing.easeOut(val, from, to)
        Swift.print("val: " + "\(val)")
        method(val)//call the property method
        if(currentFrameCount == framesToEnd){
            Swift.print("end of anim")/*when the count becomes 0 the frame ticker stops*/
            stop()
        }
        self.currentFrameCount++
        //call the method here
        //the method should be posible to be created as a inline method closure
    }
    /**
     * Start the animation
     */
    func start(){
        Swift.print("start")
        if(!CVDisplayLinkIsRunning(view.displayLink)){CVDisplayLinkStart(view.displayLink)}//start the displayLink if it isnt already running
        view.animators.append(self)//add your self to the list of animators that gets the onFrame call
    }
    /**
     * Stop the animation
     */
    func stop(){
        Swift.print("stop")
        view.animators.removeAt(view.animators.indexOf(self))
        if(view.animators.count == 0 && CVDisplayLinkIsRunning(view.displayLink)){CVDisplayLinkStop(view.displayLink)}//stops the frame ticker if there is not active running animators
    }
    //pause
    //resume
}
class Easing{
    /**
     * NOTE: If you decrease the decimal variable you increase the friction effect
     */
    class func easeOut(value : CGFloat, _ from:CGFloat, _ to:CGFloat) -> CGFloat {
        let distToGoal:CGFloat = NumberParser.distance(value, to)
        let val:CGFloat = 0.2 * distToGoal
        return val
        //let multiplier = 0.2 * NumberParser.scalar(from, to, value)
        //return NumberParser.interpolate(from, to, multiplier)
    }
}