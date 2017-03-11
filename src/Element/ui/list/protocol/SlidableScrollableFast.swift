import Cocoa

protocol SlidableScrollableFast:Fast, SlidableScrollable{}
extension SlidableScrollableFast{
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, slider!.progress)
        slider!.setProgressValue(progressVal)
        (self as Fast).setProgress(progressVal)
    }
}
