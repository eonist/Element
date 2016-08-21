import Foundation
class ComboBoxModifier{
	/**
	 * 
	 */
	class func selectByProperty(comboBox:ComboBox,_ property:String) {
        fatalError("not implemented yet")
		/*
        let index:Int = comboBox.list!.dataProvider.getItemIndex(DataProviderParser.itemByProperty(comboBox.list!.dataProvider, property)!)
		ListModifier.selectAt(comboBox.list!,index)
		let text:String = ListParser.selectedTitle(comboBox.list!)
		comboBox.headerButton!.setTextValue(text)
        */
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