import Foundation

class ComboBoxWin:Window{
    var dataProvider:DataProvider
    let initSelectedIndex:Int
    var itemHeight:CGFloat
    init(_ width: CGFloat, _ height: CGFloat, _ dataProvider:DataProvider, _ initSelectedIndex:Int, _ itemHeight:CGFloat) {
        self.initSelectedIndex = initSelectedIndex
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider
        super.init(width,height)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
    }
    override func resolveSkin() {
        super.resolveSkin()
        self.contentView = ComboBoxView(frame.width,frame.height, dataProvider, initSelectedIndex,itemHeight,nil,"comboBox")/*Sets the mainview of the window*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    required init(_ width: CGFloat, _ height: CGFloat) {fatalError("init has not been implemented")}
}
class ComboBoxView:PopupView{
    var dataProvider:DataProvider
    var list:List?
    var initSelectedIndex:Int
    var itemHeight:CGFloat// :TODO: this should be set in the css?
    init(_ width: CGFloat, _ height: CGFloat, _ dataProvider:DataProvider,_ initSelectedIndex:Int, _ itemHeight:CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        self.dataProvider = dataProvider
        self.initSelectedIndex = initSelectedIndex
        self.itemHeight = itemHeight
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        Swift.print("ComboBoxView.resolveSkin()")
        Swift.print("width: " + "\(width)")
        Swift.print("height: " + "\(height)")
        super.resolveSkin()
        list = /*addSubView*/(List(width, height, itemHeight, dataProvider, self))
        ListModifier.selectAt(list!, initSelectedIndex)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//IMPORTANT: try to open the popover window when the origin window is in fullscreen mode (works)
//Figure out how to listen to mouseEvents outside and inside NSWindow (maybe use local and global monitors)

//1. on click outside of the popup window needs to be recorded (done)
//2. click a button in popupWin sends an event and then closes it self (done)
//3. the popupWindow needs to be stored somewhere, maybe in a static variable or somewhere else in the Element framework (done)
//4. Make an universal alignment method for aligning windows, you can probably use the regular Align method here with a zeroSize and CGPoint and TopCenter as the alignment type
//5. try to animate the popup effect
//6. the popupwin must have an init with size and position,
//7. populate the window with a List/SliderList (done)
//8. hock up the List event
//9. create the ComboBoxPopUpWindow (done)
//10. you need a method that checks avilable space for the popup to be shown in (mesure screen vs origin-pos vs popup-size) <--do some doodeling etc
//11. 4px top and bottom margin for the comboboxwin, to avoid clipping the rounded corners
//12. blue color when selected, white text when selected. 
//13. 

