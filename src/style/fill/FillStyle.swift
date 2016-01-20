import Cocoa

class FillStyle:IFillStyle {
    var color:NSColor
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
}
