import Foundation
class ComboBoxModifier{
	/**
	 * 
	 */
	static func selectByProperty(comboBox:ComboBox,_ property:String) {
        let index:Int = comboBox.dataProvider!.index("property", property)!
        let title:String = comboBox.dataProvider!.getItemAt(index)!["title"]!
        comboBox.selectedIndex = index
        comboBox.headerButton!.setTextValue(title)
        
	}
	/**
	 * TODO: Implement asserting that the title exists
     * IMPORTANT: be sure that the title exists in the dataprovider
	 */
	static func select(comboBox:ComboBox,_ title:String) {
        let index:Int = comboBox.dataProvider!.getIndex(title)!
		comboBox.selectedIndex = index
		comboBox.headerButton!.setTextValue(title)
	}
}