class ComboBoxModifier{
		/**
		 * 
		 */
		static func selectByProperty(comboBox:ComboBox,property:String):void {
			var index:int = comboBox.list.dataProvider.getItemIndex(DataProviderParser.itemByProperty(comboBox.list.dataProvider, property));
			ListModifier.selectAt(comboBox.list,index);
			var text:String = ListParser.selectedTitle(comboBox.list);
			comboBox.headerButton.setText(text);
		}
		/**
		 * // :TODO: implement asserting that the title exists
		 */
		static func select(comboBox:ComboBox,title:String):void {
			ListModifier.select(comboBox.list, title);
			comboBox.headerButton.setText(title);
		}
}