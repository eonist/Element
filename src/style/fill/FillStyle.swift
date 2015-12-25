
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
protocol Copyable{
    init(_ instance:Copyable)
    func copy()->Copyable
}
class ConcreteCopyable:Copyable{
    required init(_ instance: Copyable) {
        self.init((instance as! FillStyle).color)
    }
}
extension FillStyle:Copyable{
    
    func clone(){
        
    }
}


