import Foundation
class ComboBoxModifier{
		/**
		 * 
		 */
		class func selectByProperty(comboBox:ComboBox,_ property:String) {
			var index:Int = comboBox.list.dataProvider.getItemIndex(DataProviderParser.itemByProperty(comboBox.list.dataProvider, property))
			ListModifier.selectAt(comboBox.list,index)
			var text:String = ListParser.selectedTitle(comboBox.list)
			comboBox.headerButton!.setText(text)
		}
		/**
		 * // :TODO: implement asserting that the title exists
		 */
		class func select(comboBox:ComboBox,_ title:String) {
			ListModifier.select(comboBox.list!, title)
			comboBox.headerButton.setTextValue(title)
		}
}