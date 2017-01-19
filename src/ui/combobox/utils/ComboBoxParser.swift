import Foundation
@testable import Utils

class ComboBoxParser {
    /**
     * Returns the property at index
     */
    static func selectedProperty(_ comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["property"]!
    }
    /**
     * Returns the title at index
     */
    static func selectedTitle(_ comboBox:ComboBox)->String{
        return comboBox.dataProvider!.getItemAt(comboBox.selectedIndex)!["title"]!
    }
}
