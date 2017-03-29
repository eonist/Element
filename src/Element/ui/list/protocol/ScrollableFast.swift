import Cocoa
@testable import Utils

protocol ScrollableFast:IFastList, Scrollable{}
extension ScrollableFast{
    /**
     * New
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("📜🐎 ScrollableFast.onScrollWheelChange: \(event)")
        Swift.print("progress: " + "\(progress)")
        /**/
        let val:CGFloat = ScrollableUtils.scrollTo(progress, maskSize[dir], contentSize[dir])
        contentContainer!.point[dir] = val
        /**/
        let progressVal:CGFloat = SliderListUtils.progress(event.delta[dir], interval, progress)
        (self as IFastList).setProgress(progressVal)//update the reuse algo
    }
    func onInDirectScrollWheelChange(_ event:NSEvent) {//enables momentum
        onScrollWheelChange(event)
    }
}

