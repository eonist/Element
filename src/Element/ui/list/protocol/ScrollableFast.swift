import Cocoa
@testable import Utils

protocol ScrollableFast:IFastList, Scrollable{}
extension ScrollableFast{
    /**
     * New
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {//⚠️️ It could be that we would need to use progress rather than progressVal, might be annomalies between these
        Swift.print("📜🐎 ScrollableFast.onScrollWheelChange: \(event)")
   
        let progressVal:CGFloat = SliderListUtils.progress(event.delta[dir], interval, (self as IList).progress)//TODO: Should we really store the progress value here?
        Swift.print("progressVal: " + "\(progressVal)")
        (self as ScrollableFast).setProgress(progressVal)//move the lableContainer
        (self as IFastList).setProgress(progressVal)//update the reuse algo
    }
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("ScrollableFast.setProgress progress: \(progress)")
        Swift.print("contentSize: " + "\(contentSize)")
        let val:CGFloat = ScrollableUtils.scrollTo(progress, maskSize[dir], contentSize[dir])
        Swift.print("val: " + "\(val)")
        contentContainer!.point[dir] = val
    }
    
    func onInDirectScrollWheelChange(_ event:NSEvent) {//enables momentum
        onScrollWheelChange(event)
    }
}

