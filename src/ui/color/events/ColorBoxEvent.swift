import Foundation

class ColorBoxEvent:Event {
    static var change:String = "colorBoxChange"
    var color : CGFloat
    override init(_ type:String = "", _ origin:AnyObject){
        
    }
}
