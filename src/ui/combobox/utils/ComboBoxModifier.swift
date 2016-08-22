import Foundation
class ComboBoxModifier{
	/**
	 * 
	 */
	class func selectByProperty(comboBox:ComboBox,_ property:String) {
		let item = DataProviderParser.itemByProperty(comboBox.dataProvider!, property)!
        
        let index:Int = comboBox.dataProvider!.getItemIndex(<#T##item: Dictionary<String, String>##Dictionary<String, String>#>)
		ListModifier.selectAt(comboBox.list!,index)
		let text:String = ListParser.selectedTitle(comboBox.list!)
		comboBox.headerButton!.setTextValue(text)
        
	}
	/**
	 * // :TODO: implement asserting that the title exists
     * IMPORTANT: be sure that the title exists in the dataprovider
	 */
	class func select(comboBox:ComboBox,_ title:String) {
        let index:Int = comboBox.dataProvider!.getIndex(title)!
		comboBox.selectedIndex = index
		comboBox.headerButton!.setTextValue(title)
	}
}