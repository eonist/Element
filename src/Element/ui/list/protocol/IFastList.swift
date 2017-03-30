import Foundation
@testable import Utils

protocol IFastList:IList {
    var dir:Dir {get set}
    var selectedIdx:Int? {get set}
    var pool:[FastListItem] {get set}
    func reUse(_ listItem:FastListItem)
    func createItem(_ index:Int) -> Element
    var inActive:[FastListItem] {get set}
}
/**
 * Basically the Fast protocol allows you to reuse Items in a "carousell-like-list"
 * NOTE: The Fast name is because if you dont reuse items in a long list it will be slow.
 */
extension IFastList{
    /**
     * PARAM: progress (0-1)
     * NOTE: setProgress is in this class because RBFastSliderList doesn't extend SliderList, and both classes needs to extend this method
     * NOTE: override this method in SliderFastList and RBSliderFastList
     *
     * The concept is simple, you only show items that are within the limits as you scroll up and down. (these items only exists virtually, untill they are revealed if they are within the limits)
     * With these two rules: you should be able to create the algorithm that lay out items at a progress value
     * Stage.1: Remove items outside Limits
     * Stage.2: stack items to cover the visible area
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("🐎 IFastList.setProgress(\(progress)) ")
        //ScrollableUtils.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)
        }
    }
    /**
     * Creates, applies data and aligns items defined in PARAM: range
     * TODO: You can optimize the range stuff later when all cases work (it would be possible to creat a custom diff method that is simpler and faster than using generic intersection,diff and exclude)
     * NOTE: this method is inside an extension because it doesn't need to be overriden by super classes
     */
    func renderItems(_ range:Range<Int>){
        Swift.print("IFastlist.renderItems()")
        let old = currentVisibleItemRange
        let firstOldIdx:Int = old.start
        /*⚠️️⚠️️⚠️️Figure out which items to remove from pool⚠️️⚠️️⚠️️*/
        let diff = RangeParser.difference(range, old)//may return 1 or 2 ranges
        if(diff.1 != nil){
            let start = diff.1!.start - firstOldIdx
            inActive += pool.splice2(start, diff.1!.length)
        }
        if(diff.0 != nil){
            let start = diff.0!.start - firstOldIdx
            inActive += pool.splice2(start, diff.0!.length)
        }
        /*⚠️️⚠️️⚠️️Figure out which items to add to pool⚠️️⚠️️⚠️️*/
        let diff2 = RangeParser.difference(old,range)
        if(diff2.1 != nil){
            let startIdx = diff2.1!.start
            let endIdx = diff2.1!.end
            var items:[FastListItem] = []
            for i in (startIdx..<endIdx){
                let item:Element = inActive.count > 0 ? inActive.popLast()!.item : createItem(i)
                let fastListItem:FastListItem = (item:item,idx:i)
                reUse(fastListItem)/*applies data and position*/
                items.append(fastListItem)
            }
            if(items.count > 0){
                var idx:Int = items.first!.idx - firstOldIdx//index in pool
                idx = idx.clip(0, pool.count)
                _ = ArrayModifier.mergeInPlaceAt(&pool, &items, idx)
            }
        }
        if(diff2.0 != nil){
            let startIdx = diff2.0!.start
            let endIdx = diff2.0!.end
            var items:[FastListItem] = []
            for i in (startIdx..<endIdx){
                let item:Element = inActive.count > 0 ? inActive.popLast()!.item : createItem(i)
                let fastListItem:FastListItem = (item:item,idx:i)
                reUse(fastListItem)//applies data and position
                items.append(fastListItem)
            }
            if(items.count > 0){
                var idx:Int = items.first!.idx - firstOldIdx//index in pool
                idx = idx.clip(0, pool.count)
                _ = ArrayModifier.mergeInPlaceAt(&pool, &items, idx)
            }
        }
    }
    /**
     * Returns the range to render (based on items in DP and how the lableContainer is positioned)
     */
    var visibleItemRange:Range<Int>{
        let firstVisibleItemThatCrossTopOfView = firstVisibleItem
        let lastVisibleItemThatIsWithinBottomOfView = lastVisibleItem
        let visibleItemRange:Range<Int> = firstVisibleItemThatCrossTopOfView..<lastVisibleItemThatIsWithinBottomOfView
        return visibleItemRange
    }
    /**
     * Returns the current visible item range in List
     */
    var currentVisibleItemRange:Range<Int>{
        let firstIdx:Int = pool.count > 0 ? pool.first!.idx : 0
        let lastIdx:Int = pool.count > 0 ? pool.first!.idx + pool.count : 0
        let currentVisibleItemRange:Range<Int> = firstIdx..<lastIdx
        return currentVisibleItemRange
    }
    /**
     * reUses all items from idx, to end idx in pool
     * NOTE: this method is called after dp change: add/remove
     */
    func reUseFromIdx(_ idx:Int){
        if(idx >= firstVisibleItem && idx <= lastVisibleItem){
            let startIdx = idx - firstVisibleItem
            var endIdx = lastVisibleItem - firstVisibleItem
            endIdx = Swift.min(dp.count,endIdx)
            for i in startIdx..<endIdx{/*reUse affected items if item is within visible view*/
                let fastListItem = pool[i]
                reUse(fastListItem)
            }
        }
    }
    /**
     * Sets an item to selected, deselects other items, works with dp indecies
     */
    func selectAt(dpIdx:Int){/*convenience*/
        fatalError("⚠️️ uncomment the code bellow, debug mode only")
        /*
         let idx:Int? = ArrayParser.first(pool, dpIdx, {$0.idx == $1})?.item.idx/*Converts dpIndex to lableContainerIdx*/
         if(idx != nil){ListModifier.selectAt(self, idx!)}
         else{SelectModifier.selectAll(lableContainer!, false)}/*unSelect all if an item outside visible view is selected*/
         selectedIdx = dpIdx
         */
    }
    /**
     * Force a refresh of all items
     */
    func reUseAll(){
        pool.forEach{reUse($0)}
    }
}



/*
 //call this method after resize etc
 //clear inActive array, if any are left, can happen after resize etc
 //This could be usefull when size of view changes from big to small etc, or when going from many items to few
 
 inActive.forEach{
 Swift.print("remove inactive")
 $0.item.removeFromSuperview()
 }
 inActive.removeAll()
 
 */

/*
 private class Utils{
 /**
 * Temp solution
 * NOTE: There is a more permanent way to disable animation with the actionForLayer, but it requires a change in InteractiveView etc
 * NOTE: maybe we can avoid hiding by just placing the view outside the mask item.y = top - item.height should to
 */
 static func hide(_ view:NSView, _ isHidden:Bool){
 CATransaction.begin()
 CATransaction.setDisableActions(true)
 //Change properties here without animation
 view.isHidden = isHidden
 CATransaction.commit()
 }
 }
 */
