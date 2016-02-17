import Cocoa

class SelectParser {
    /**
     * Returns the  first selected ISelectable in an array of ISelectables or a NSView with ISelectables
     */
    class func selected(view:NSView) -> ISelectable? {
        let selectables = selectables(view);
        for each (var selectable : ISelectable in selectables) {if(selectable.selected) {return selectable}}
        return nil
    }
    /**
     * Returns an array from every child that is an ISelectable in @param displayObjectContainer
     */
    class func selectables(view:NSView)->Array<ISelectable> {
        return NSViewParser.childrenOfType(view, ISelectable.self);
    }
}