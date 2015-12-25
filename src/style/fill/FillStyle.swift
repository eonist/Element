
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
    func setProp(copyable:Copyable)
}
class ConcreteCopyable{
    required init(_ instance: Copyable) {
       self
    }
    func copy() -> Copyable {
        return FillStyle(self)
    }
    
}
extension FillStyle:Copyable{
    func setProp(copyable: Copyable) {
        //must be overriden in
    }
    func clone()->Copyable{
         return FillStyle(color)
    }
}


