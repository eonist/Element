import Cocoa
@testable import Utils

extension Element{
    /**
     * Convenience
     */
    convenience init(_ width: CGFloat, _ height: CGFloat, _ isDisabled:Bool, _ isFocused:Bool = false, _ parent:ElementKind? = nil,_ id:String? = nil){
        self.init(width,height,parent,id)
        self.isDisabled = isDisabled
        self.isFocused = isFocused
    }
    /**
     * Convenience
     */
    convenience init(_ width: CGFloat , _ height: CGFloat , _ x:CGFloat , _ y:CGFloat , _ parent:ElementKind? = nil,_ id:String? = nil){
        self.init(width,height,parent,id)
        setPosition(CGPoint(x,y))
    }
    /**
     * New
     * NOTE: check out UnfoldParser.retrieveUnFoldable for hirarchical version of this method
     */
    func element<T:ElementKind>(_ id:String,_ type:T.Type? = nil) -> T?{
        return ElementParser.element(self, id, type)
    }
}
extension Event{//TODO: ⚠️️ rename to Element+Event.swift
    /**
     * new
     */
    func assert(_ type:String, id:String) -> Bool{
        return self.type == type && (self.origin as? ElementKind)?.id == id
    }
    /**
     * New
     * is origin child of a parent with ID == parentID
     */
    func isChildOf(parentID:String) -> Bool{
        let matchMethod:NSViewAsserter.MatchMethod = {(a,_) in
            guard let element = (a as? ElementKind) else {return false}
            return element.id == parentID
        }
        return NSViewAsserter.hasParent(self.origin as? NSView, nil,matchMethod:matchMethod)
    }
}
