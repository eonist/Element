import Foundation
/** 
 * @Note for multiSelect option make MultiCheckComboBox.as aand CheckComboBox?
 * @Note: to get the height while the list is pulled down: comboBox.height * comboBox.maxShowingItems
 * // :TODO: add isScrollBarVisible as an argument at the end, butbefore, parent and name
 * // :TODO: add a way to set the init selected list item, and have this update the header, (if headerText != null that is)
 * // :TODO: add height as an argument to the constructor
 * // :TODO: find a way to add a mask that can have rounded corners, if a TextButton has a square fill then it overlaps outside the combobox
 * //closeOnClick
 * //defaultText
 */
class ComboBox{
	private var _headerButton:TextButton?
	private var _itemHeight:CGFloat// :TODO: this should be set in the css?
	private var _dataProvider:DataProvider
	private var _list:SliderList?
	private var _isOpen:Bool
	private var _depth:Int?/*used to store the temp sprite depth so the popover can hover over other instance siblings*/
	private var _initSelected:Int
	init(_ width:Number = NaN, _ height:Number = NaN, _ itemHeight:Number = NaN ,_ dataProvider:DataProvider? = nil, _ isOpen:Boolean = false, _ initSelected:int = 0, _ parent:IElement? = nil, _ id:String? = nil){
		self.itemHeight = itemHeight
		self.dataProvider = dataProvider
		self.isOpen = isOpen
		self.initSelected = initSelected
		super.init(width,height,parent,id,classId)
	}
	override func resolveSkin(){
		super.resolveSkin();
		headerButton = addSubView(TextButton(width, itemHeight, false, false, "", self))// :TODO: - _itemHeight should be something else
		list = addSubView(SliderList(width, height, itemHeight, dataProvider, self))
		ListModifier.selectAt(list, initSelected)
		headerButton.setText(ListParser.selectedTitle(list))
		setOpen(isOpen)
	}
	func onHeaderMouseDown(event:ButtonEvent) {
		setOpen(!isOpen)
		/*send this event*/ComboBoxEvent(ComboBoxEvent.headerClick,self)
	}
	func onGlobalClick() {//On clicks outside combobox, close the combobox
		if (!hitTestPoint(x, y)) {//you sort of check if the mouse-click didnt happen within the bounds of the comboBox
			setOpen(false);
			//remove the globalListner here
		}
	}
}