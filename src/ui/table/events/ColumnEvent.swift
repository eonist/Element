import Foundation

class ColumnEvent:Event{
    static var select:String = "columnEventSelect"
    var rowIndex:Int?
    init(_ type:String = "", rowIndex:Int, _ origin:AnyObject){
        self.rowIndex = rowIndex
        super.init(type, origin)
    }
}