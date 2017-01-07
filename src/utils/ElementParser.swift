import Cocoa

class ElementParser{
    /**
     * Returns all children in @param element that is of type IElement
     * NOTE: if this doesnt work just use the array casting technique with the NSParser.children method
     */
    static func children<T>(view:NSView,_ type:T.Type)->Array<T> {
        return NSViewParser.childrenOfType(view, type)
    }
    /**
     * Returns an Array instance comprised of Selector instances for each (element,classId,id and state) in the element "cascade" (the spesseficity)
     * NOTE: to get the stackString use: ElementParser.stackString(button) and StyleParser.describe(StyleResolver.style(button))
     */
    static func selectors(element:IElement)->Array<ISelector>{
        //Swift.print("ElementParser.selectors()")
        let elements:Array<IElement> = ArrayModifier.append(parents(element),element)
        var selectors:Array<ISelector> = []
        elements.forEach {selectors.append(selector($0))}
        return selectors
    }
    /**
     *
     */
    static func selector(element:IElement)->ISelector{
        let elmnt:String = element.getClassType()
        //if(e.classId != null) selector.classIds = e.classId.indexOf(" ") != -1 ? e.classId.split(" ") : [e.classId]
        let id:String = element.id ?? ""
        let states:[String] = (element.skin != nil ? element.skin!.state : element.getSkinState()).match("\\b\\w+\\b")/*Matches words with spaces between them*/
        return Selector(elmnt,[],id,states)
    }
    /**
     * Returns an array populated with IElement parents of the target (Basically the ancestry)
     */
    static func parents(element:IElement)->Array<IElement> {
        var parents:Array<IElement> = []
        var parent:IElement? = element.getParent() as? IElement// :TODO: seperate this into a check if its DO then that, if its Window then do that
        while(parent != nil) {/*loops up the object hierarchy as long as the parent is a Element supertype*/
            ArrayModifier.unshift(&parents,parent!)
            parent = parent!.getParent() as? IElement
        }
        return parents
    }
    /**
     * This method can be used to print the StyleSelector for an Element instance 
     * Returns the absolute ancestry as a space delimited string in this format: elementId:classIds#id:states
     */
    static func stackString(element:IElement)->String{
        return SelectorParser.string(selectors(element))
    }
}