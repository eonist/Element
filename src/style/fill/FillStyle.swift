
import Cocoa

class FillStyle:IFillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
    func copy() -> ICopyable2 {
        return FillStyle(self)
    }
}

extension FillStyle:ICopyable2{
    convenience init(_ fillStyle:FillStyle){
        self.init(fillStyle.color)
    }
    
}


protocol ICopyable2{
    func copy()->ICopyable2
}

