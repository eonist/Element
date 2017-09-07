import Cocoa
@testable import Utils

class ElasticSliderScrollerFastList5:SliderScrollerFastList5,Elastic5 {
    lazy var moverGroup:MoverGroup = MoverGroup(self.setProgressValue,self.maskSize,self.contentSize)//⚠️️ remember to add eventHandler
    lazy var rbContainer:Container = self.createRBContainer/*Needed for the overshot animation*/
    //
    private var elasticHandler:ElasticSliderScrollerFastListHandler {return handler as! ElasticSliderScrollerFastListHandler}//move this to extension somewhere
    override lazy var handler:ProgressHandler = ElasticSliderScrollerFastListHandler(progressable:self)
}



