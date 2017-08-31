import Cocoa
@testable import Utils
/** 
 * NOTE: For multiSelect option make MultiCheckComboBox.as aand CheckComboBox?
 * NOTE: To get the height while the list is pulled down: comboBox.height * comboBox.maxShowingItems
 * TODO: ⚠️️ Add isScrollBarVisible as an argument at the end, butbefore, parent and name
 * TODO: ⚠️️ Add a way to set the init selected list item, and have this update the header, (if headerText != null that is)
 * TODO: ⚠️️ Add height as an argument to the constructor
 * TODO: ⚠️️ Find a way to add a mask that can have rounded corners, if a TextButton has a square fill then it overlaps outside the combobox
 * //closeOnClick
 * //defaultText
 * TODO: ⚠️️ Upgrade the ComboBox to support popping open a window that hovers above the origin window. It needs to align it self to the screen correctly etc
 */
class ComboBox:Element{
    lazy var headerButton:TextButton = createHeaderButton()
    var itemHeight:CGFloat// :TODO: this should be set in the css?
    var dataProvider:DataProvider?
    var isOpen:Bool = false
    var selectedIndex:Int
    var popupWindow:ComboBoxWin?
    init( itemHeight:CGFloat = NaN , dataProvider:DataProvider? = nil,  isOpen:Bool = false,  selectedIndex:Int = 0, size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider
        self.isOpen = isOpen
        self.selectedIndex = selectedIndex
        super.init(size: size, id: id)
    }
	override func resolveSkin(){
		super.resolveSkin()
		_ = headerButton
        //setOpen(isOpen)//this isn't really needed as the combobox should never be open on creation, remove the initiater argument aswell i suppose
	}
	func onHeaderMouseDown(_ event:ButtonEvent) {
        Swift.print("onHeaderMouseDown")
        setOpen(!isOpen)
        super.onEvent(ComboBoxEvent(ComboBoxEvent.headerClick,selectedIndex,self))/*send this event*/
	}
	/**
	 * The select event should be fired only onReleaseInside not as it is now onPress
	 */
	func onListSelect(_ event:ListEvent) {
        Swift.print("onListSelect")
        let list: Listable3 = event.origin as! List3
        selectedIndex = List3Parser.selectedIndex(list)
		let text:String = List3Parser.titleAt(list, selectedIndex)
        Swift.print("text: " + "\(text)")
		headerButton.setTextValue(text)
        super.onEvent(ComboBoxEvent(ComboBoxEvent.listSelect,selectedIndex,self))/*Send this event*/
        popupWindow!.close()/*After we process the ListEvent, we close the PopupWindow*/
		setOpen(false)
	}
    func onClickOutside() {//was->onClickOutsidePopupWin
        Swift.print("onClickOutsidePopupWin")
        if(!CGRect(CGPoint(),headerButton.frame.size).contains(headerButton.localPos())){/*hittest to avoid calling setOpen if the headerButton is clicked while the popupwin is open*/
            setOpen(false)
        }
    }
	override func onEvent(_ event:Event){
        if(event.type == Event.update && event.origin === popupWindow!.contentView){onClickOutside()}
		if(event.type == ListEvent.select && event.origin === (popupWindow!.contentView as! ComboBoxView).list) {onListSelect(event as! ListEvent)}
		if(event.type == ButtonEvent.down && event.origin === headerButton){onHeaderMouseDown(event as! ButtonEvent)}
	}
	func setOpen(_ isOpen:Bool) {
        Swift.print("setOpen: " + "\(isOpen)")
        if(isOpen){
            popupWindow = ComboBoxWin(skinSize.w,skinSize.h, dataProvider!, selectedIndex,itemHeight)
            //🔶 swift 3 update on the bellow line
            var comboBoxPos:CGPoint = convert(NSPoint(0,0), to: self.window!.contentView)/*POV of the window*/
            comboBoxPos += CGPoint(0 , itemHeight)/*BottomRight corner pos of the header button in the POV of the window*/
            let winPos:CGPoint = popupWindow!.unFlipScreenPosition(self.window!.topLeft + comboBoxPos)//comboBoxPos
            WinModifier.position(popupWindow!, winPos)
            (popupWindow!.contentView as! WindowView).event = self.onEvent/*Add event handler*/
        }else{
            //do nothing
        }
        self.isOpen = isOpen
	}
	override func setSize(_ width:CGFloat, _ height:CGFloat)  {
		super.setSize(width, height)
		headerButton.setSize(width, StyleMetricParser.height(headerButton.skin!)!)/*temp solution*/
	}
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //dep
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN ,_ dataProvider:DataProvider? = nil, _ isOpen:Bool = false, _ selectedIndex:Int = 0, _ parent:ElementKind? = nil, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider
        self.isOpen = isOpen
        self.selectedIndex = selectedIndex
        super.init(size:CGSize(width,height),id:id)
    }
}
extension ComboBox{
    var selectedProperty:String{/*convenience*/
        return ComboBoxParser.selectedProperty(self)
    }
    var selectedTitle:String{/*convenience*/
        return ComboBoxParser.selectedTitle(self)
    }
    func createHeaderButton() -> TextButton{
        let headerButton = self.addSubView(TextButton(self.skinSize.w, self.itemHeight,"", self))//TODO: - _itemHeight should be something else
        let selectedTitle:String = self.dataProvider!.getItemAt(self.selectedIndex)!["title"]!
        headerButton.setTextValue(selectedTitle)
        return headerButton
    }
}



