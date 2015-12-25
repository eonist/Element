
import Cocoa

class FillStyle:IFillStyle,Copyable {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
    
}

extension FillStyle{
    convenience init(_ fillStyle:FillStyle){
        self.init(fillStyle.color)
    }
    func copy() -> Copyable {
        return FillStyle(self)
    }
}
protocol Copyable{
    func copy()->Copyable
}