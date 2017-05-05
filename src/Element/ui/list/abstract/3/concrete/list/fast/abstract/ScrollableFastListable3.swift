import Cocoa
@testable import Element
@testable import Utils

protocol ScrollableFastListable3:FastListable3,Scrollable3{}

extension ScrollableFastListable3{
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("ScrollableFastListable3.onScrollWheelChange()")
        let primaryProgress:CGFloat = SliderListUtils.progress(event, dir, interval(dir), progress(dir))
        (self as FastListable3).setProgress(primaryProgress)
        (self as Scrollable3).setProgress(primaryProgress,dir)
    }
}
//let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
