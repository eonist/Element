import Foundation
@testable import Utils

class CheckModifier {
    /**
     * UnChecks all in PARAM: items exept PARAM: target
     */
    static func unCheckAllExcept(_ exceptionItem:Checkable, _ checkables:[Checkable]) {// :TODO: refactor this function// :TODO: rename to unSelectAllExcept
        checkables.forEach { if($0 !== exceptionItem && $0.getChecked()) { $0.setChecked(false)} }
    }
    /**
     * Removes the RadioButton passed through the PARAM: radioButton
     */
    static func removeCheckable(_ checkables:inout [Checkable], _ item:Checkable)->Checkable? {
        if let i = checkables.index(where: {$0 === item}){
            return checkables.splice2(i, 1)[0]// :TODO: dispatch something?
        }
        return nil
    }
}
