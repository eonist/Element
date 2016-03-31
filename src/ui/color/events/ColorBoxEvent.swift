import Foundation

class ColorBoxEvent:Event {
    static var change:String = "colorBoxChange"
    override init(_ type:String = "", _ origin:AnyObject){
        super.init(type, origin)
    }
}
extension ColorBoxEvent{
    var color:CGFloat
}