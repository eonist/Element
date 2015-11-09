import Cocoa

protocol IFillStyle{
    var color: NSColor { get set }
}
/*
* Convenience method for the Graphics class
*/
extension IFillStyle {
    var cgColor: CGColor {return NSColorParser.cgColor(color)}
}