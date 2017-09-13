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

//How can you trottle something to always be bellow 60fps?, 🔑
    //actually 60fps is not static it could drop bellow that so you need to drop into onFrame
    //when onScrollWheelEnter -> start frameTicker
    //when onScrollWheelExit -> stop frameTicker
