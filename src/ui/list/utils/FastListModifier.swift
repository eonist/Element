import Foundation

class FastListModifier {
    /**
     * NOTE: setting the selected attribute in the dataProvider is important because when we spoof list items we recycle old items and so we dont want to inherit the selected state
     */
    static func select(list:FastList, _ index:Int, _ isSelected:Bool){
        ListModifier.selectAt(list, index)//Handles the visible items in the lable container
        list.dataProvider.setValue(index,"selected",String(isSelected))
        list.dataProvider.setValuesExceptAt(index, "selected", String(!isSelected))
    }
}
