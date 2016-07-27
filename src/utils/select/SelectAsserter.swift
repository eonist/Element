import Cocoa

class SelectAsserter {
    /**
     *
     */
    class func hasSelected(view:NSView) -> Bool {
        return SelectParser.selected(view) != nil
    }
    /**
     *
     */
    class func hasSelected(selectables:Array<ISelectable>) -> Bool {
        return SelectParser.selected(selectables) != nil
    }
}
