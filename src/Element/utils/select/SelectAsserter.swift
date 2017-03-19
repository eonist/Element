import Cocoa

class SelectAsserter {
    /**
     *
     */
    static func hasSelected(_ view:NSView) -> Bool {
        return SelectParser.selected(view) != nil
    }
    /**
     *
     */
    static func hasSelected(_ selectables:[ISelectable]) -> Bool {
        return SelectParser.selected(selectables) != nil
    }
}
