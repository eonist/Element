import Cocoa
@testable import Utils
//rename to ....Accessor
protocol ElasticDecorator:ProgressableDecorator,Elastic5 {}

extension ElasticDecorator{
    var moverGroup: MoverGroup {get{return elastic.moverGroup}set{elastic.moverGroup = newValue}}
    var rbContainer: Container {return elastic.rbContainer}
    var elastic:Elastic5 {return progressable as! Elastic5}
}
