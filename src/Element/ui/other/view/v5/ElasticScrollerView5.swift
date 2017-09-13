import Cocoa
@testable import Utils

class ElasticScrollerView5:ScrollerView5,Elastic5 {
    lazy var moverGroup:MoverGroup = self.createMoverGroup
    lazy var rbContainer:Container = self.createRBContainer/*Needed for the overshot animation*/
    //
    private var elasticHandler:ElasticScrollerHandler5 {return handler as! ElasticScrollerHandler5}//move this to extension somewhere
    override lazy var handler:ProgressHandler = ElasticScrollerHandler5(progressable:self)
}

