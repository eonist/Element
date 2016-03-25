import Cocoa
/**
 * @Note: Keep the TreeListItem name, since you might want to create TreeMenuItem one day
 * // :TODO: why doesnt the treeListItem extend a class that ultimatly extends a TextButton?, has it something to do with the indentation via css?
 */
class TreeListItem:SelectCheckBoxButton{
    var itemContainer : Container?
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ isSelected:Bool = false, parent:IElement? = nil, id:String = "") {
        super.init(width, height, text, isSelected, isChecked, parent, id)
    }
    override func resolveSkin(){
        super.resolveSkin();
        itemContainer = addSubView(Container(NaN,NaN,self,"lable"))//0. add _itemContainer
        itemContainer!.hidden = isChecked
    }
    func addItem(item:NSView){
        itemContainer!.addSubView(item)
        ElementModifier.floatChildren(itemContainer!)
    }
    func addItemAt(item:NSView,_ index:Int){
        itemContainer!.addSubviewAt(item, index)
        ElementModifier.floatChildren(itemContainer!)
    }
    func removeAt(index:Int){
        itemContainer!.removeSubviewAt(index)
        ElementModifier.floatChildren(itemContainer!)
    }
    func open(){
        setChecked(true)
        checkBox?.onEvent(CheckEvent(CheckEvent.check, true, checkBox!))
    }
    func close(){
        setChecked(false)
        checkBox?.onEvent(CheckEvent(CheckEvent.check, false, checkBox!))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}