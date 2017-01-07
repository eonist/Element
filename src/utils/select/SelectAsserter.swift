import Cocoa

class SelectAsserter {
    /**
     *
     */
    static func hasSelected(view:NSView) -> Bool {
        return SelectParser.selected(view) != nil
    }
    /**
     *
     */
    static func hasSelected(selectables:Array<ISelectable>) -> Bool {
        return SelectParser.selected(selectables) != nil
    }
}
