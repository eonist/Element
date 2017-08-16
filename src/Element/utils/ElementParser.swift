import Cocoa
@testable import Utils

class ElementParser{
    /**
     * Returns all children in PARAM: element that is of type IElement
     * NOTE: If this doesnt work just use the array casting technique with the NSParser.children method
     */
    static func children<T>(_ view:NSView,_ type:T.Type? = nil)->[T] {
        return NSViewParser.childrenOfType(view, type)
    }
    /**
     * Returns an Array instance comprised of Selector instances for each (element,classId,id and state) in the element "cascade" (the spesseficity)
     * NOTE: To get the stackString use: ElementParser.stackString(button) and StyleParser.describe(StyleResolver.style(button))
     */
    static func selectors(_ element:ElementKind)->[SelectorKind]{
        let elements:[ElementKind] = parents(element) + [element]
        return elements.map{selector($0)}
    }
    static func selector(_ element:ElementKind)->SelectorKind{
        let elmnt:String = element.getClassType()
        //if(e.classId != null) selector.classIds = e.classId.indexOf(" ") != -1 ? e.classId.split(" ") : [e.classId]
        let id:String = element.id ?? ""
        let states:[String] = (element.skin?.state ?? element.getSkinState()).split(" ")/*match("\\b\\w+\\b") Matches words with spaces between them*/
        return Selector(elmnt,[],id,states)
    }
    /**
     * Returns an array populated with IElement parents of the target (Basically the ancestry)
     * NOTE: loops up hierarachy
     */
    static func parents(_ element:ElementKind)->[ElementKind] {
        var parents:[ElementKind] = []
        var parent:ElementKind? = element.getParent() as? ElementKind// :TODO: seperate this into a check if its DO then that, if its Window then do that
        while(parent != nil) {/*loops up the object hierarchy as long as the parent is a Element supertype*/
            parents.append(parent!)
            parent = parent!.getParent() as? ElementKind
        }
        return parents.reversed()
    }
    /**
     * This method can be used to print the StyleSelector for an Element instance 
     * Returns the absolute ancestry as a space delimited string in this format: elementId:classIds#id:states
     * TODO: ⚠️️ returns an trailing : could be a bug?
     */
    static func stackString(_ element:ElementKind)->String{
        return SelectorParser.string(selectors(element))
    }
    /**
     * New
     */
    static func element<T:ElementKind>(_ parent:NSView, _ id:String, _ type:T.Type? = nil) -> T?{
        return parent.subviews.lazy.flatMap{$0 as? T}.first(where: {$0.id! == id})
    }
}
