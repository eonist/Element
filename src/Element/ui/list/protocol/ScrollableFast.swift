import Cocoa

protocol ScrollableFast:IFastList, Scrollable{}
extension ScrollableFast{
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("📜🐎 ScrollableFast.onScrollWheelChange: \(event)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, slider!.progress)
        (self as IFastList).setProgress(progressVal)//update the reuse algo
    }
}
