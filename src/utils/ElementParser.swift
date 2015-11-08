import Foundation


class ElementParser{
    /**
     * Returns an Array instance comprised of Selector instances for each (element,classId,id and state) in the element "cascade" (the spesseficity)
     * @Note to get the stackString use: trace(SelectorUtils.toString(StyleResolver.stack(checkButton)));
     */
    class func selectors(element:IElement)->Array<ISelector>{
        let elements:Array<IElement> = ArrayModifier.append(parents(element),element)
        var selectors:Array<ISelector> = []
        for  e : IElement in elements {
            let selector:Selector = Selector();
            selector.element = e.getClassType();
            //if(e.classId != null) selector.classIds = e.classId.indexOf(" ") != -1 ? e.classId.split(" ") : [e.classId];
            //selector.id = e.id;
            //selector.states = (e.skin != null ? e.skin.state : e.getSkinState()).match(/\b\w+\b/g);/*Matches words with spaces between them*/
            selectors.append(selector);
        }
        return selectors;
    }
    /**
     * Returns an array populated with IElement parents of the target (Basically the ancestry)
     */
    class func parents(element:IElement)->Array<IElement> {
        var parents:Array<IElement> = [];
        var parent:IElement? = element.getParent()// :TODO: seperate this into a check if its DO then that, if its Window then do that
        while(parent != nil) {//loops up the object hierarchy as long as the parent is a Element supertype
            ArrayModifier.unshift(&parents,parent!)
            parent = parent!.getParent()
        }
        return parents;
    }
}