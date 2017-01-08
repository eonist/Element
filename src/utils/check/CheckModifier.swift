import Foundation

class CheckModifier {
    /**
     * UnChecks all in PARAM: items exept PARAM: target
     */
    static func unCheckAllExcept(exceptionItem:ICheckable, _ checkables:Array<ICheckable>) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        checkables.forEach {
            if($0 !== exceptionItem && $0.getChecked()) {
                $0.setChecked(false)
            }
        }
    }
    /**
     * Removes the RadioButton passed through the PARAM: radioButton
     */
    static func removeCheckable(inout checkables:Array<ICheckable>, _ item:ICheckable)->ICheckable? {
        for i in 0..<checkables.count{
            if (checkables[i] === item) {
                return checkables.splice2(i, 1) as? ICheckable// :TODO: dispatch something?
            }
        }
        return nil
    }
}