import Cocoa

class SelectParser {
    /**
     * Returns the  first selected ISelectable in an array of ISelectables or a NSView with ISelectables
     */
    class func selected(scope:*):ISelectable {
        if(scope as NSView) scope = selectables(scope);
        else if((scope as Array) == false) throw new IllegalOperationError(scope+" type not supported");
        for each (var selectable : ISelectable in scope) if(selectable.selected) return selectable;
        return nil;
    }
    /**
     * Returns an array from every child that is an ISelectable in @param displayObjectContainer
     */
    class func selectables(view:NSView)->Array<ISelectable> {
        return NSViewParser.childrenOfType(view, ISelectable.self);
    }
}