import Cocoa

protocol IFillStyle{
    var color: NSColor { get set }
}
/*
* Convenience method for the Graphics class
*/
extension IFillStyle {
    var cgColor: CGColor {return CGColorParser.cgColor(color)}
}
extension IFillStyle{
    func copy() -> IFillStyle {
        return FillStyle(self.color)
    }
}