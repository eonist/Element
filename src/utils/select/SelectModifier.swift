import Cocoa

class SelectModifier {
    /**
     * Unselects all in @param items except @param target
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ aSelectables:Array<ISelectable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        
        if(aSelectables is NSView) {}
        else if(aSelectables is Array<ISelectable>) {selectables = aSelectables as! Array<ISelectable>}
        for selectable : ISelectable in selectables {if(selectable !== exceptionItem && selectable.isSelected) {selectable.setSelected(false)}}
    }
}
extension SelectModifier{
    /**
     * 
     */
    class func unSelectAllExcept(exceptionItem:ISelectable, _ view:NSView){
        var selectables:Array<ISelectable> = selectables = SelectParser.selectables(aSelectables as! NSView)
    }
}