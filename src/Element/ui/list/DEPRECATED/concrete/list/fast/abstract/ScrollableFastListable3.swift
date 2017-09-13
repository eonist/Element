import Cocoa
@testable import Utils

protocol ScrollableFastListable3:FastListable3,Scrollable3{}

extension ScrollableFastListable3{
    func onScrollWheelChange(_ event:NSEvent) {
        //Swift.print("ScrollableFastListable3.onScrollWheelChange()")
        let primaryProgress:CGFloat = SliderListUtils.progress(event, dir, interval(dir), progress(dir))
        (self as FastListable3).setProgress(primaryProgress)//TODO: ⚠️️ this is not good. that you have to call setProgress one after the other.
        (self as Scrollable3).setProgress(primaryProgress,dir)
        ScrollFastList3.numOfEvents! += 1
    }
}
//let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)

//How can you trottle something to always be bellow 60fps?, 
    //actually 60fps is not static it could drop bellow that so you need to drop into onFrame
    //when onScrollWheelEnter -> start frameTicker
    //when onScrollWheelExit -> stop frameTicker
