import Cocoa

protocol ILineStyle{
    var color: NSColor { get set }
    var thickness: CGFloat { get set }
    var lineCap: CGLineCap { get set }
    var lineJoin: CGLineJoin { get set }
    var miterLimit: CGFloat { get set }
}