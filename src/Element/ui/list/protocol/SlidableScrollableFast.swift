import Cocoa

protocol SlidableScrollableFast:IFastList2, SlidableScrollable{}
extension SlidableScrollableFast{
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("🏂📜🐎 SlidableScrollable2.onScrollWheelChange: \(event)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, slider!.progress)
        slider!.setProgressValue(progressVal)
        (self as IFastList2).setProgress(progressVal)
    }
}
