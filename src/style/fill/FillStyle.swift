
import Cocoa

class FillStyle:ConcreteCopyable,IFillStyle {
    
    var color:NSColor
    /**
     *
     */
    init(_ color:NSColor = NSColor.clearColor()){
        self.color = color
    }

    required init(_ instance: Copyable) {
        fatalError("init has not been implemented")
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
    
    
}
extension FillStyle:Copyable{
    func setProp(copyable: Copyable) {
        //must be overriden in
    }
    func clone()->Copyable{
         return FillStyle(color)
    }
    func copy() -> Copyable {
        return FillStyle(color)
    }
}


