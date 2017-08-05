import Foundation
@testable import Utils

extension Element{
    /**
     * Convenience
     */
    convenience init(_ width: CGFloat, _ height: CGFloat, _ isDisabled:Bool, _ isFocused:Bool = false, _ parent:IElement? = nil,_ id:String? = nil){
        self.init(width,height,parent,id)
        self.isDisabled = isDisabled
        self.isFocused = isFocused
    }
    /**
     * Convenience
     */
    convenience init(_ width: CGFloat , _ height: CGFloat , _ x:CGFloat , _ y:CGFloat , _ parent:IElement? = nil,_ id:String? = nil){
        self.init(width,height,parent,id)
        setPosition(CGPoint(x,y))
    }
    /**
     * New
     */
    func element<T:IElement>(_ id:String,_ type:T.Type? = nil) -> T?{
        return ElementParser.element(self, id, type)
    }
}
extension Event{
    /**
     * new
     */
    func assert(_ type:String, id:String) -> Bool{
        return self.type == type && (self.origin as? ElementKind)?.id == id
    }
}
