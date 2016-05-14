import Foundation
/**
 * NOTE: you can derive the slected via the combobox item it self. So no need to pass the selected along in the event
 */
class ComboBoxEvent :Event{
    static var click:String = "comboBoxEventClick"
	static var headerClick:String = "comboBoxEventHeaderClick"
	static var listSelect:String = "comboBoxEventListSelect"
    private var index : Int
    init(_ type: String, _ index:Int, _ origin: AnyObject) {
        self.index = index
        super.init(type, origin)
    }
}
extension ComboBoxEvent{
    /**
     * Convenience
     * NOTE: Keeps the event light-weight by not referencing the item directly
     * NOTE: you may have to reconsider this as the selected item may have de-selected before the event arrives (think cpu threads etc)
     */
    var selected:ISelectable{
        //continue here: index from where? See similar event class in list
        //you could even just grab the index from the list it self
        return (origin as! ComboBox).list!.lableContainer!.subviews[index] as! ISelectable
    }
}