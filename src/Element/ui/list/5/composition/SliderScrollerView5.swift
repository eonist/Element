import Cocoa
@testable import Utils

class SliderScrollView5:ProgressableView5,Slidable5,Scrollable5 {
    lazy var scrollHandler:ScrollHandler = .init(progressable:self)
    /**
     * TODO: ⚠️️ Try to override with generics ContainerView<VerticalScrollable>  etc, in swift 4 this could probably be done with where Self:... nopp wont work 🚫
     */
    override open func scrollWheel(with event: NSEvent) {
        scrollHandler.scroll(event)
        super.scrollWheel(with: event)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
