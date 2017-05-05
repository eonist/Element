import Foundation
@testable import Utils
@testable import Element

class ElasticSlideScrollList3:SlideList3,ElasticSlidableScrollable3 {
    lazy var moverGroup:MoverGroup? = self.moverGrp
    override func onEvent(_ event:Event) {
        if(event.type == AnimEvent.stopped){
            Swift.print("ElasticSlideScrollList3.onEvent: " + "\(event.type)")
            let dir:Dir = event.origin === moverGroup!.yMover ? .ver : .hor
            Swift.print("bounce back anim stopp dir: \(dir)")
            hideSlider(dir)/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
private extension ElasticSlideScrollList3{
    var moverGrp:MoverGroup {
        let group = MoverGroup(self.setProgress,self.maskSize,self.contentSize);
        group.event = self.onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
}

/*override open func scrollWheel(with event: NSEvent) {
 Swift.print("SlideView3.scrollWheel() \(event.type)")
 super.scrollWheel(with: event)
 if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
 showSlider()
 }
 /*else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
 //hideSlider()
 }*/
 }*/
