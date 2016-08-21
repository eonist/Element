import Foundation

class ComboBoxParser {
    /**
     * Returns the property at index
     */
    class func selectedProperty(comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["property"]!
    }
    /**
     * Returns the title at index
     */
    class func selectedTitle(comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["title"]!
    }
}
