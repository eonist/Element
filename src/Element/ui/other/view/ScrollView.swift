import Cocoa
/**
 * When the the user scrolls
 * NOTE: this Method is totally academic, can be removed 
 */
class ScrollView: DisplaceView, Scrollable {
    override func scrollWheel(with event: NSEvent) {//TODO: move to displaceview
        scroll(event)/*forward the event to the extension which adjust Slider and calls setProgress in this method*/
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
}
