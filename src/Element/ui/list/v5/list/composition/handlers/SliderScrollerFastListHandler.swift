import Cocoa
@testable import Utils

class SliderScrollerFastListHandler:ScrollerFastListHandler,SlidableDecorater {
    /**
     * TODO: ⚠️️ you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    override func onScrollWheelChange(_ event:NSEvent) {
        super.onScrollWheelChange(event)
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        setProgress(progressVal)
    }
    override func onInDirectScrollWheelChange(_ event:NSEvent) {//enables momentum
        super.onInDirectScrollWheelChange(event)
        onScrollWheelChange(event)
    }
    override func onScrollWheelEnter() {
        super.onScrollWheelEnter()
        showSlider()
    }
    override func onScrollWheelCancelled() {
        super.onScrollWheelEnter()
        hideSlider()
    }
    override func onScrollWheelExit() {
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
        super.setProgress(point)
        //Swift.print("🏂 Slidable3.setProgress: " + "\(point)")
        slider(.hor).setProgressValue(point.x)
        slider(.ver).setProgressValue(point.y)
    }
}
