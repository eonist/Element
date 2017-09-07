import Foundation

class ElasticScrollerFastList5:ScrollerFastList5,Elastic5 {
    lazy var moverGroup:MoverGroup = MoverGroup(self.setProgressVal,self.maskSize,self.contentSize)//⚠️️ remember to add eventHandler
    lazy var rbContainer:Container = self.createRBContainer/*Needed for the overshot animation*/
    //
    private var elasticHandler:ElasticScrollerFastListHandler {return handler as! ElasticScrollerFastListHandler}//move this to extension somewhere
    override lazy var handler:ProgressHandler = ElasticScrollerFastListHandler(progressable:self)
}
