import Foundation

class CheckModifier {
    /**
     * UnChecks all in @param items exept @param target
     */
    class func unCheckAllExcept(exceptionItem:ICheckable, _ checkables:Array<ICheckable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        for checkable : ICheckable in checkables {if(checkable !== exceptionItem && checkable.getChecked()) {checkable.setChecked(false)}}
    }
    /**
     * Removes the RadioButton passed through the @param radioButton
     */
    class func removeCheckable(inout checkables:Array<ICheckable>, _ item:ICheckable)->ICheckable? {
        for (var i:Int=0; i < checkables.count; i++) {if (checkables[i] === item) {return checkables.splice(i, 1) as? ICheckable}}// :TODO: dispatch something?
        return nil
    }
}