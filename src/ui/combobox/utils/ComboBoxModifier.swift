import Foundation
class ComboBoxModifier{
	/**
	 * 
	 */
	class func selectByProperty(comboBox:ComboBox,_ property:String) {
		let index:Int = comboBox.list!.dataProvider.getItemIndex(DataProviderParser.itemByProperty(comboBox.list!.dataProvider, property)!)
		ListModifier.selectAt(comboBox.list!,index)
		let text:String = ListParser.selectedTitle(comboBox.list!)
		comboBox.headerButton!.setTextValue(text)
	}
	/**
	 * // :TODO: implement asserting that the title exists
	 */
	class func select(comboBox:ComboBox,_ title:String) {
		ListModifier.select(comboBox.list!, title)
		comboBox.headerButton!.setTextValue(title)
	}
}