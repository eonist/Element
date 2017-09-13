import Cocoa
@testable import Utils

protocol Slidable5:Progressable5 {
    var hSlider:Slider {get}
    var vSlider:Slider {get}
    /*func updateSlider()*/
    func slider(_ dir:Dir) -> Slider/*?*/
}
