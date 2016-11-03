import Foundation

class FastListModifier {
    /**
     * NOTE: setting the selected attribute in the dataProvider is important because when we spoof list items we recycle old items and so we dont want to inherit the selected state
     */
    static func select(list:FastList, _ index:Int/*dp idx*/, _ isSelected:Bool){
        list.selectedIdx = index//set the cur selectedIdx in fastList
        var viewIndex:Int?
        
        for i in 0..<list.visibleItems.count{
            if(index == visibleItems[i].idx){ListModifier.selectAt(list, index)}//if the index is currently visible then select it to see UI changes
        }
        
    }
}
