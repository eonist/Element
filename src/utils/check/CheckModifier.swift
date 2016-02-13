import Foundation

class CheckModifier {
    /**
     * UnChecks all in @param items exept @param target
     */
    class func unCheckAllExcept(exceptionItem:ICheckable, _ checkables:Array<ICheckable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        for checkable : ICheckable in checkables {if(checkable !== exceptionItem && checkable.getChecked()) {checkable.setChecked(false)}}
    }
}


//continue here: revert the checked vs isChecked system. use the legacu version