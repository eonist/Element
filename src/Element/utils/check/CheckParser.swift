import Foundation
@testable import Utils

class CheckParser {
    /**
     * Returns an ICheckable at a spessific index
     */
    func getCheckableAt(_ checkables:[Checkable],_ index:Int)->Checkable? {// :TODO: consider moving in to util class or just write it up as a note
        return checkables[safe:index]
    }
}
