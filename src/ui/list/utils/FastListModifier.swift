import Foundation

class FastListModifier {
    /**
     * 
     */
    static func select(list:IList, _ index:Int, _ isSelected:Bool){
        ListModifier.selectAt(list, index)
        list.dataProvider.setValue(index,"selected",String(isSelected))
        list.dataProvider.setValuesExceptAt(index, "selected", String(!isSelected))
    }
}
