import Cocoa

protocol SlidableScrollable2:Slidable2,Scrollable2{}

extension SlidableScrollable2{
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("🏂📜 SlidableScrollable2.onScrollWheelChange: \(event)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, (self as Slidable2).interval, progress)
        slider!.setProgressValue(progress)
        setProgress(progressVal)
    }
    func onScrollWheelEnter() {//IMPORTANT: methods that are called from deep can only override upstream
        showSlider()
    }
    func onScrollWheelExit() {//IMPORTANT: methods that are called from deep can only override upstream
        hideSlider()
    }
}
