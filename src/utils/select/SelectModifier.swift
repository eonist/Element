import Cocoa

class SelectModifier {
    /**
     * Unselects all in @param items except @param target
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ aSelectables:AnyObject) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        var selectables:Array<ISelectable> = []
        if(selectables is NSView) {selectables = SelectParser.selectables(aSelectables)}
        else if((selectables is Array<ISelectable>) == false) {selectables = aSelectables as! Array<ISelectable>}
        
        for selectable : ISelectable in selectables {if(selectable !== exceptionItem && selectable.isSelected) {selectable.setSelected(false)}}
    }
}
