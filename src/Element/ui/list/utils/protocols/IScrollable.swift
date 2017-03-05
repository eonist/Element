import Foundation
/**
 * Scrollable is for scroling things, basically content within a mask
 */
protocol IScrollable:class {
    var height:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemHeight:CGFloat{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    var lableContainer:Container? {get set}
}
