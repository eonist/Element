import Foundation
/**
 * NOTE: you can derive the slected via the combobox item it self. So no need to pass the selected along in the event
 */
class ComboBoxEvent :Event{
    static var click:String = "comboBoxEventClick"
	static var headerClick:String = "comboBoxEventHeaderClick"
	static var listSelect:String = "comboBoxEventListSelect"
}
extension ComboBoxEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not referencing the item directly
     * NOTE: you may have to reconsider this as the selected item may have de-selected before the event arrives (think cpu threads etc)
     */
    var selected:ISelectable{
        
        //continue here: index from where? See similar event class in list
        
        return (origin as! ComboBox).list!.lableContainer!.subviews[index] as! ISelectable
    }
}