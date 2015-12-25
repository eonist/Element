
import Cocoa

class FillStyle:ConcreteCopyable,IFillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }
    
}
protocol Copyable{
    init(_ instance:Copyable)
    func copy()->Copyable
}
class ConcreteCopyable:Copyable{
    required init(_ instance: Copyable) {
       
    }
    func copy() -> Copyable {
        return FillStyle(self)
    }
}
extension FillStyle:Copyable{
    
    func clone()->Copyable{
         return FillStyle(color)
    }
}


