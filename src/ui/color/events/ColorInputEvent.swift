import Cocoa

class ColorInputEvent:Event {
    static var change:String = "colorBoxChange"//probably should be ColorInputChange
    static var colorBoxDown:String = "colorBoxDown"//this shouldnt exist?
    override init(_ type:String = "", _ origin:AnyObject){
        super.init(type, origin)
    }
}
extension ColorInputEvent{
    var color:NSColor? {return (origin as! IColorInput).color}
}