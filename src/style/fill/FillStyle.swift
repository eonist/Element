
import Cocoa

class FillStyle:IFillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
    func copy() -> Copyable {
        return FillStyle(self)
    }
}
extension FillStyle:Copyable{
    convenience init(_ fillStyle:FillStyle){
        self.init(fillStyle.color)
    }
}

protocol Copyable{
    func copy()->Copyable
}

