import Cocoa
@testable import Utils

class ColorInputEvent:Event {
    static var change:String = "colorBoxChange"//TODO: probably should be ColorInputChange
    static var colorBoxDown:String = "colorBoxDown"//TODO: this shouldn't exist?
    override init(_ type:String = "", _ origin:AnyObject){
        super.init(type, origin)
    }
}
extension ColorInputEvent{
    var color:NSColor? {return (origin as! IColorInput).color}
}
