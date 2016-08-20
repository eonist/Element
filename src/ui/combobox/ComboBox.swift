import Cocoa
/** 
 * @Note for multiSelect option make MultiCheckComboBox.as aand CheckComboBox?
 * @Note: to get the height while the list is pulled down: comboBox.height * comboBox.maxShowingItems
 * // :TODO: add isScrollBarVisible as an argument at the end, butbefore, parent and name
 * // :TODO: add a way to set the init selected list item, and have this update the header, (if headerText != null that is)
 * // :TODO: add height as an argument to the constructor
 * // :TODO: find a way to add a mask that can have rounded corners, if a TextButton has a square fill then it overlaps outside the combobox
 * //closeOnClick
 * //defaultText
 * TODO: Upgrade the ComboBox to support popping open a window that hovers above the origin window. It needs to align it self to the screen correctly etc
 */
class ComboBox:Element{
    var headerButton:TextButton?
    var itemHeight:CGFloat// :TODO: this should be set in the css?
    var dataProvider:DataProvider?
    //var list:SliderList?
    var isOpen:Bool = false
    //var depth:Int?/*used to store the temp sprite depth so the popover can hover over other instance siblings*/
    var selectedIndex:Int
    var popupWindow:ComboBoxWin?
	init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN ,_ dataProvider:DataProvider? = nil, _ isOpen:Bool = false, _ selectedIndex:Int = 0, _ parent:IElement? = nil, _ id:String? = nil){
		self.itemHeight = itemHeight
		self.dataProvider = dataProvider
		self.isOpen = isOpen
		self.selectedIndex = selectedIndex
		super.init(width,height,parent,id)
	}
	override func resolveSkin(){
		super.resolveSkin()
		headerButton = addSubView(TextButton(width, itemHeight,"", self))// :TODO: - _itemHeight should be something else
        let selectedTitle:String = dataProvider!.getItemAt(selectedIndex)!["title"]!
        Swift.print("selectedTitle: " + "\(selectedTitle)")
        headerButton!.setTextValue(selectedTitle)
        setOpen(isOpen)//this isn't really needed as the combobox should never be open on creation, remove the initiater argument aswell i suppose
	}
	func onHeaderMouseDown(event:ButtonEvent) {
        Swift.print("onHeaderMouseDown")
		setOpen(!isOpen)
        super.onEvent(ComboBoxEvent(ComboBoxEvent.headerClick,selectedIndex,self))/*send this event*/
	}
	/**
	 * the select event should be fired only onReleaseInside not as it is now onPress
	 */
	func onListSelect(event:ListEvent) {
        Swift.print("onListSelect")
        let list:IList = event.origin as! List
		let text:String = ListParser.selectedTitle(list)
        Swift.print("text: " + "\(text)")
		headerButton!.setTextValue(text)
        popupWindow!.close()
		setOpen(false)
	}
    func onClickOutside() {//onClickOutsidePopupWin
        Swift.print("onClickOutsidePopupWin")
        setOpen(false)
    }
	override func onEvent(event:Event){
        if(event.type == Event.update && event.origin === popupWindow!){onClickOutside()}
		if(event.type == ListEvent.select && event.origin === (popupWindow!.contentView as! ComboBoxView).list) {onListSelect(event as! ListEvent)}
		if(event.type == ButtonEvent.down && event.origin === headerButton){onHeaderMouseDown(event as! ButtonEvent)}
	}
    
	func setOpen(isOpen:Bool) {
        Swift.print("setOpen")
        if(isOpen){
            popupWindow = ComboBoxWin(width,height, dataProvider!, selectedIndex,itemHeight)
            var comboBoxPos:CGPoint = convertPoint(CGPoint(0,0), toView: self.window!.contentView)/*POV of the window*/
            comboBoxPos += CGPoint(0 , itemHeight)/*bottomRight corner pos of the header button in the POV of the window*/
            let winPos:CGPoint = popupWindow!.unFlipScreenPosition(self.window!.topLeft + comboBoxPos)//comboBoxPos
            WinModifier.position(popupWindow!, winPos)
            
            (popupWindow!.contentView as! WindowView).event = self.onEvent/*add event handler*/
        }else{
            //
        }
        self.isOpen = isOpen
	}
	override func setSize(width:CGFloat, _ height:CGFloat)  {
		super.setSize(width, height)
		headerButton!.setSize(width, StylePropertyParser.height(headerButton!.skin!)!)/*temp solution*/
	}
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}





