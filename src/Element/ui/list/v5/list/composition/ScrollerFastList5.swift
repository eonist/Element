import Cocoa
@testable import Utils

class ScrollerFastList5:FastList5 {
    private var scrollHandler:ScrollerFastListHandler {return handler as! ScrollerFastListHandler}
    override lazy var handler:ProgressHandler = ScrollerFastListHandler(progressable:self)
    override open func scrollWheel(with event: NSEvent) {
//        Swift.print("ScrollerFastList5.scrollWheel")
        scrollHandler.scroll(event)
        super.scrollWheel(with: event)
    }
}
