import Cocoa
@testable import Utils

class ElasticSliderScrollerView5:SliderScrollerView5,Elastic5 {
    lazy var moverGroup:MoverGroup = self.moverGrp
    lazy var rbContainer:Container = self.createRBContainer/*Needed for the overshot animation*/
    
    private var elasticHandler:ElasticSliderScrollerHandler {return handler as! ElasticSliderScrollerHandler}//⚠️️ this can be added to a prtocol and extension, in fact all handlers like this can be
    override lazy var handler:ProgressHandler = ElasticSliderScrollerHandler(progressable:self)
    
    override func onEvent(_ event:Event) {
        if event.type == AnimEvent.stopped {
            Swift.print("ElasticSlideScrollList3.onEvent: " + "\(event.type)")
            let dir:Dir = event.origin === moverGroup.yMover ? .ver : .hor
            Swift.print("bounce back anim stopp dir: \(dir)")
            hideSlider(dir)/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
