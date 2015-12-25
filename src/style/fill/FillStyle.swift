
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
    func setProps(copyable:Copyable)
}
class ConcreteCopyable{
    required init(_ instance: Copyable) {
       fatalError("must be overriden in subclass")
    }
}
extension FillStyle:Copyable{
    func setProps(copyable: Copyable) {
        //must be overriden in
    }
    func copy() -> Copyable {
        return FillStyle(color)
    }
}


