import Foundation


class ElementParser{

    /**
     * Returns an array populated with IElement parents of the target (Basically the ancestry)
     */
    class func parents(element:IElement)->Array<IElement> {
        var parents:Array<IElement> = [];
        var parent:IElement? = element.getParent()// :TODO: seperate this into a check if its DO then that, if its Window then do that
        while(parent is IElement) {//loops up the object hierarchy as long as the parent is a Element supertype
            ArrayModifier.unshift(&parents,parent!)
            parent = parent!.getParent()
        }
        return parents;
    }
}