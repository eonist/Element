import Cocoa
@testable import Element
@testable import Utils

protocol SlideableScrollableFastListable3:FastListable3,SlidableScrollable3 {}

extension SlideableScrollableFastListable3{
    func onScrollWheelChange(_ event:NSEvent) {
        let primaryProgress:CGFloat = SliderListUtils.progress(event, dir, interval(dir), progress(dir))
        (self as FastListable3).setProgress(primaryProgress)
        (self as Scrollable3).setProgress(primaryProgress,dir)
        (self as Slidable3).setProgress(CGPoint(0,primaryProgress))//<-quickfix
    }
}
