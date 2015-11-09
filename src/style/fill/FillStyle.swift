
import Cocoa

class FillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
}

extension IFillStyle {
    var cgColor: CGColor {return NSColorParser.cgColor(color)}
}