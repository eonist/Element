import Foundation

class SelectModifier {
    /**
    * Unselects all in @param items except @param target
    */
    class func unSelectAllExcept(exceptionItem:ISelectable, selectables:*):void {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        if(selectables is DisplayObjectContainer) selectables = SelectParser.selectables(selectables);
        else if((selectables is Array) == false) throw new IllegalOperationError("type not supported");
        if(exceptionItem as ISelectable == null) throw new IllegalOperationError("item does not implement ISelectable: "+exceptionItem);
        for each (var selectable : ISelectable in selectables) if(selectable != exceptionItem && selectable.selected) selectable.setSelected(false);
    }
}
