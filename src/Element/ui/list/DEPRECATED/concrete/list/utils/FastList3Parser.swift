import Cocoa
@testable import Utils

class FastList3Parser {
    /**
     * We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies
     */
    static func idx(_ fastList:FastListable3, _ item:NSView) -> Int?{
        return fastList.pool.first(where:{$0.item === item})?.idx
    }
}


class FastList5Parser {
    /**
     * We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies
     */
    static func idx(_ fastList:FastListable5, _ item:NSView) -> Int?{
        return fastList.pool.first(where:{$0.item === item})?.idx
    }
    /**
     * New
     */
    static func idx(fastList:FastListable5, dpIdx:Int) -> Int?{
        return ArrayParser.first(fastList.pool, dpIdx, {$0.idx == $1})?.item.idx/*Converts dpIndex to lableContainerIdx*/
    }
}
