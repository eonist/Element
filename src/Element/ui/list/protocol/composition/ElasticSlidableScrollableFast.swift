import Cocoa
@testable import Utils

protocol ElasticSlidableScrollableFast:IFastList2,ElasticScrollable, Slidable {
    var rbContainer:Container?{get set}
}
