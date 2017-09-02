import Foundation
@testable import Utils

extension TreeDP {
    /**
     * Returns idx3d for idx2d
     */
    subscript(_ idx2d:Int) -> [Int] {
        return hashList[idx2d]
    }
    /**
     * Returns idx2d for idx3d
     */
    subscript(_ idx3d:[Int]) -> Int? {
        return hashList.index(where: {$0 == idx3d})
    }
}
