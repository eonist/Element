import Cocoa
@testable import Utils

class ComboBoxWin:Window{
    var dataProvider:DataProvider
    let initSelectedIndex:Int
    var itemHeight:CGFloat
    init(_ width: CGFloat, _ height: CGFloat, _ dataProvider:DataProvider, _ initSelectedIndex:Int, _ itemHeight:CGFloat) {
        self.initSelectedIndex = initSelectedIndex
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider
        super.init(width,height)
        self.animationBehavior = NSWindow.AnimationBehavior.utilityWindow/*Fades the window in and out slightly*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        self.contentView = ComboBoxView(frame.size.width,frame.size.height, dataProvider, initSelectedIndex,itemHeight,nil,"comboBox")/*Sets the mainview of the window*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    required init(_ width: CGFloat, _ height: CGFloat) {fatalError("init has not been implemented")}
}
class ComboBoxView:PopupView{
    var dataProvider:DataProvider
    var list:List3?
    var initSelectedIndex:Int
    var itemHeight:CGFloat//TODO:this should be set in the css?
    init(_ width:CGFloat, _ height:CGFloat, _ dataProvider:DataProvider,_ initSelectedIndex:Int, _ itemHeight:CGFloat, _ parent: ElementKind? = nil, _ id: String? = nil) {
        self.dataProvider = dataProvider
        self.initSelectedIndex = initSelectedIndex
        self.itemHeight = itemHeight
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        Swift.print("ComboBoxView.resolveSkin()")
        Swift.print("width: " + "\(skinSize.w)")
        Swift.print("height: " + "\(skinSize.h)")
        super.resolveSkin()
        list = addSubView(List3(skinSize.w, skinSize.h, CGSize(itemHeight,itemHeight), dataProvider,.ver, self))
        List3Modifier.selectAt(list!, initSelectedIndex)
    }
    /**
     * override func onEvent(event: Event) {}
     */
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    required init(from decoder: Decoder) throws {fatalError("init(from:) has not been implemented")}
}
