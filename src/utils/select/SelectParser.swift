import Cocoa

class SelectParser {
    /**
     * Returns an array from every child that is an ISelectable in @param displayObjectContainer
     */
    func selectables(displayObjectContainer:NSView)->Array<ISelectable> {
        return DisplayObjectParser.childrenOfType(displayObjectContainer, ISelectable);
    }
}
