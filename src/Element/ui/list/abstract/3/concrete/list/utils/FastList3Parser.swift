import Cocoa

class FastList3Parser {
    /**
     * We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies
     */
    static func idx(_ fastList:FastListable3, _ item:NSView) -> Int?{
        return fastList.pool.first(where:{$0.item === item})?.idx
    }
}
