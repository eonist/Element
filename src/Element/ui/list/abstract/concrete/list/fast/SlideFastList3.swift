import Cocoa
@testable import Utils

class SlideFastList3:FastList3,Slidable3 {
    lazy var horSlider:Slider? = self.hSlider
    lazy var verSlider:Slider? = self.vSlider
}
