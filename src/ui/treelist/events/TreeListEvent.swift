import Foundation
@testable import Utils

class TreeListEvent:Event {
    static var change:String = "treeListEventChange"
    override init(_ type:String = "", _ origin:AnyObject) {
        super.init(type, origin)
    }
}
