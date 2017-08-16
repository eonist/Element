import Cocoa
@testable import Utils

class SelectParser {
    /**
     * Returns the  first selected ISelectable in an array of an NSView with ISelectables (returns nil if it doesn't exist)
     * TODO: Rename to firstSelected
     */
    static func selected(_ view:NSView) -> Selectable? {
        let selectables:[Selectable] = self.selectables(view)
        return selected(selectables)
    }
    /**
     * Returns the  first selected ISelectable in an array of ISelectables or a
     * TODO: Rename to firstSelected
     */
    static func selected(_ selectables:[Selectable]) -> Selectable? {
        return selectables.first(where: {$0.getSelected()})
    }
    /**
     * Returns an array from every child that is an ISelectable in PARAM: displayObjectContainer
     */
    static func selectables(_ view:NSView)->[Selectable] {
        return NSViewParser.childrenOfType(view, Selectable.self)
    }
    /**
     * Returns all selectables that are selected
     */
    static func allSelected(_ selectables:[Selectable])->[Selectable] {
        return selectables.filter(){$0.getSelected()}
    }
    /**
     * Returns the index of the first selected ISelectable instance in a NSView instance (returns -1 if non is found)
     * TODO: make a similar method for Array instead of NSView
     * NOTE: you could return nil instead of -1
     */
    static func index(_ view:NSView) -> Int{
        return view.subviews.filter() {$0 as? Selectable != nil}.index(where: {($0 as! Selectable).selected}) ?? -1
    }
}
