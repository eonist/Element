
import Cocoa

class FillStyle:IFillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
    func copy() -> ICopyable {
        return FillStyle(self)
    }
}

extension FillStyle:ICopyable{
    convenience init(_ fillStyle:FillStyle){
        self.init(fillStyle.color)
    }
    
}

class Copyable:ICopyable{
    func copy()->ICopyable{
        
    }
}
