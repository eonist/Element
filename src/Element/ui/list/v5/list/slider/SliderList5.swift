import Cocoa
@testable import Utils
//we dont use this class directly, but extend it
class SliderList5:ProgressableList5,Slidable5 {
    lazy var hSlider:Slider = self.createHSlider
    lazy var vSlider:Slider = self.createVSlider
    
    override func onEvent(_ event:Event) {
        if let event:SliderEvent = event as? SliderEvent, event.type == SliderEvent.change {
            let dir:Dir = event.origin === hSlider ? .hor : .ver
            handler.setProgress(event.progress,dir)
        }
        super.onEvent(event)
    }
}
