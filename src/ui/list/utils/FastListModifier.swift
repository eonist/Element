import Foundation

class FastListModifier {
    /**
     * Sets selectedIndex in fastList and makes the appropriate UI changes to the visibleItems
     * PARAM: index: dataProvider index
     */
    static func select(list:FastList, _ index:Int, _ isSelected:Bool){
        list.selectedIdx = index/*set the cur selectedIdx in fastList*/
        for (i,_) in list.visibleItems.enumerate(){
            if(index == list.visibleItems[i].idx){ListModifier.selectAt(list, i)}/*if the index is currently visible then select it to see UI changes*/
        }
    }
}