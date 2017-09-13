import Foundation

class SliderScrollerFastList5:ScrollerFastList5,Slidable5{
    lazy var hSlider:Slider = self.createHSlider
    lazy var vSlider:Slider = self.createVSlider
    private var sliderHandler:SliderScrollerFastListHandler {return handler as! SliderScrollerFastListHandler}
    override lazy var handler:ProgressHandler = SliderScrollerFastListHandler(progressable:self)
}
