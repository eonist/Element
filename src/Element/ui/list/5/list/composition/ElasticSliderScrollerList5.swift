import Cocoa
@testable import Utils

class ElasticSliderScrollerList:SliderScrollerList5,Elastic5 {
    lazy var moverGroup:MoverGroup = self.moverGrp
    lazy var rbContainer:Container = self.rubberBandContainer/*Needed for the overshot animation*/
    
    private var elasticHandler:ElasticScrollerHandler5 {return handler as! ElasticScrollerHandler5}//⚠️️ this can be added to a prtocol and extension, in fact all handlers like this can be
    
    override func onEvent(_ event:Event) {
        if(event.type == AnimEvent.stopped){
            Swift.print("ElasticSlideScrollList3.onEvent: " + "\(event.type)")
            let dir:Dir = event.origin === moverGroup.yMover ? .ver : .hor
            Swift.print("bounce back anim stopp dir: \(dir)")
            hideSlider(dir)/*hides the slider when bounce back anim stopps*/
        }
        super.onEvent(event)
    }
}
