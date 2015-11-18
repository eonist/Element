import Cocoa

protocol ILineStyle{
    var color: NSColor { get set }
    var thickness: CGFloat { get set }
    var lineCap: CGLineCap { get set }//TODO: rename to capStyle?
    var lineJoin: CGLineJoin { get set }//TODO: rename to jointStyle
    var miterLimit: CGFloat { get set }
}