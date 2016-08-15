import Cocoa

class SelectParser {
    /**
     * Returns the  first selected ISelectable in an array of an NSView with ISelectables (returns nil if it doesnt exist)
     * TODO: Rename to firstSelected
     */
    class func selected(view:NSView) -> ISelectable? {
        let selectables:Array<ISelectable> = self.selectables(view)
        return selected(selectables)
    }
    /**
     * Returns the  first selected ISelectable in an array of ISelectables or a
     * TODO: Rename to firstSelected
     */
    class func selected(selectables:Array<ISelectable>) -> ISelectable? {
        for selectable : ISelectable in selectables {if(selectable.getSelected()) {return selectable}}
        return nil
    }
    /**
     * Returns an array from every child that is an ISelectable in @param displayObjectContainer
     */
    class func selectables(view:NSView)->Array<ISelectable> {
        return NSViewParser.childrenOfType(view, ISelectable.self)
    }
    /**
     * Returns all selectables that are selected
     */
    class func allSelected(selectables:Array<ISelectable>)->Array<ISelectable> {
        var selected:Array<ISelectable> = []
        for selectable : ISelectable in selectables{ if(selectable.getSelected()) {selected.append(selectable)} }
        return selected
    }
    /**
     * Returns the index of the first selected ISelectable instance in a NSView instance (returns -1 if non is found)
     * TODO: make a similar method for Array instead of NSView
     * NOTE: you could return nil instead of -1
     */
    class func index(view:NSView) -> Int{
        let numOfSubViews:Int = view.numSubViews/*CPU-optimization*/
        for var i = 0; i < numOfSubViews; ++i{
            let child:NSView? = view.getSubViewAt(i)
            if(child is ISelectable && (child as! ISelectable).selected){ return i }
        }
        return -1
    }
}