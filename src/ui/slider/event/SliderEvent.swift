import Foundation
/**
 * The progress was refrenced in an extension at first, but it seems more precise to include it in the event. Think multi threaded CPU etc
 */
class SliderEvent :Event{
    static var change:String = "sliderEventChange"
    var progress:CGFloat
    init(_ type: String, _ progress:CGFloat, _ origin: AnyObject) {
        self.progress = progress
        super.init(type, origin)
    }
}