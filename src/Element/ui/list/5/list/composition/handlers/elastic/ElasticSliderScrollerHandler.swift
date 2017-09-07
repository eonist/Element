import Cocoa
@testable import Utils

class ElasticSliderScrollerHandler:ElasticScrollerHandler5,SlidableDecorater {
    
    override func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("ElasticSliderScrollerHandler.onScrollWheelChange")
        super.onScrollWheelChange(event)
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        setProgress(progressVal)
    }
    override func onInDirectScrollWheelChange(_ event:NSEvent) {//enables momentum
        super.onInDirectScrollWheelChange(event)
        onScrollWheelChange(event)
    }
    override func onScrollWheelEnter() {
        Swift.print("SliderScrollerHandler.onScrollWheelEnter")
        super.onScrollWheelEnter()
        showSlider()
    }
    override func onScrollWheelCancelled() {
        super.onScrollWheelEnter()
        hideSlider()
    }
    override func onScrollWheelExit() {
        Swift.print("SliderScrollerHandler.onScrollWheelExit")
        super.onScrollWheelExit()
        hideSlider()
    }
    override func onScrollWheelMomentumBegan(_ event:NSEvent) {
        super.onScrollWheelMomentumBegan(event)
        showSlider()//cancels out the hide call when onScrollWheelExit is called when you release after pan gesture
    }
    /**
     * Called only be called when scrollwheel becomes stationary. find the code that does this.
     */
    override func onScrollWheelMomentumEnded()  {
        super.onScrollWheelMomentumEnded()
        hideSlider()
    }
    /**
     * (0-1)
     */
    override func setProgress(_ point:CGPoint){
//        Swift.print("SliderScrollerHandler.setProgress")
//        super.setProgress(point)
        //Swift.print("🏂 Slidable3.setProgress: " + "\(point)")
        slider(.hor).setProgressValue(point.x)
        slider(.ver).setProgressValue(point.y)
    }
    
}
