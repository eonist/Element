import Foundation

class ComboBoxParser {
    /**
     * Returns the property at index
     */
    static func selectedProperty(comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["property"]!
    }
    /**
     * Returns the title at index
     */
    static func selectedTitle(comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["title"]!
    }
}
