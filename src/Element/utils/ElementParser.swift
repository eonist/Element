import Cocoa
@testable import Utils

class ElementParser{
    /**
     * Returns all children in PARAM: element that is of type IElement
     * NOTE: If this doesnt work just use the array casting technique with the NSParser.children method
     */
    static func children<T>(_ view:NSView,_ type:T.Type)->[T] {
        return NSViewParser.childrenOfType(view, type)
    }
    /**
     * Returns an Array instance comprised of Selector instances for each (element,classId,id and state) in the element "cascade" (the spesseficity)
     * NOTE: To get the stackString use: ElementParser.stackString(button) and StyleParser.describe(StyleResolver.style(button))
     */
    static func selectors(_ element:IElement)->[ISelector]{
        let elements:[IElement] = parents(element) + [element]
        return elements.map {selector($0)}
    }
    static func selector(_ element:IElement)->ISelector{
        let elmnt:String = element.getClassType()
        //if(e.classId != null) selector.classIds = e.classId.indexOf(" ") != -1 ? e.classId.split(" ") : [e.classId]
        let id:String = element.id ?? ""
        let states:[String] = {
            if let skin = element.skin{
                return skin.state
            }else{
                return element.getSkinState()).match("\\b\\w+\\b")/*Matches words with spaces between them*/
            }
        }()
        return Selector(elmnt,[],id,states)
    }
    /**
     * Returns an array populated with IElement parents of the target (Basically the ancestry)
     */
    static func parents(_ element:IElement)->[IElement] {
        var parents:[IElement] = []
        var parent:IElement? = element.getParent() as? IElement// :TODO: seperate this into a check if its DO then that, if its Window then do that
        while(parent != nil) {/*loops up the object hierarchy as long as the parent is a Element supertype*/
            parents.append(parent!)
            parent = parent!.getParent() as? IElement
        }
        return parents.reversed()
    }
    /**
     * This method can be used to print the StyleSelector for an Element instance 
     * Returns the absolute ancestry as a space delimited string in this format: elementId:classIds#id:states
     */
    static func stackString(_ element:IElement)->String{
        return SelectorParser.string(selectors(element))
    }
}
