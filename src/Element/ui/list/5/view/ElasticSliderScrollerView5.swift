import Cocoa
@testable import Utils

class ElasticSliderScrollerView5:SliderScrollerView5,Elastic5 {
    lazy var moverGroup:MoverGroup = self.moverGrp
    lazy var rbContainer:Container = self.rubberBandContainer
    override func resolveSkin() {
        super.resolveSkin()
        moverGroup.xMover.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        moverGroup.yMover.event = onEvent
    }
    override func onEvent(_ event:Event) {
        if event.type == AnimEvent.stopped {
            //Swift.print("ElasticSlideScrollList3.onEvent: " + "\(event.type)")
            let dir:Dir = event.origin === moverGroup.yMover ? .ver : .hor
            Swift.print("bounce back anim stopp dir: \(dir)")
            hideSlider(dir)/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}

