class ComboBoxEvent extends Event {
	public static const click:String = "ComboBoxEventClick";
	public static const HEADER_CLICK:String = "comboBoxEventHeaderClick";
	public static const LIST_SELECT : String = "comboBoxEventListSelect";
	
	public function ComboBoxEvent(type:String, selected:ISelectable, bubbles:Boolean = false, cancelable:Boolean = false) {
		_selected = selected;
		super(type, bubbles, cancelable);
	}
}

class ComboBoxEvent :Event{
    static var click:String = "ComboBoxEventClick"
	static var headerClick:String = "comboBoxEventHeaderClick"
	static var listSelect:String = "comboBoxEventListSelect"
    /*private var _selected : ISelectable;*/
    init(_ type: String, _ origin: AnyObject) {
        super.init(type, origin)
    }
}