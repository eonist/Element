import Cocoa
/**
 * @Note: Keep the TreeListItem name, since you might want to create TreeMenuItem one day
 * // :TODO: why doesnt the treeListItem extend a class that ultimatly extends a TextButton?, has it something to do with the indentation via css?
 */
class TreeListItem:SelectCheckBoxButton,ITreeListItem{//this class doesnt need an init method since its exactly the same as the one it extends
    var itemContainer:Container?
    override init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ isSelected:Bool = false, _ parent:IElement? = nil, _ id:String = "") {
        super.init(width, height, text, isSelected, isChecked, parent, id)
    }
    override func resolveSkin(){
        super.resolveSkin();
        itemContainer = addSubView(Container(NaN,NaN,self,"lable"))//0. add _itemContainer
        itemContainer!.hidden = !getChecked()
    }
    /**
     * Takes care of adding items to the itemContainer
     */
    func addItem(item:NSView){
        itemContainer!.addSubView(item)
        ElementModifier.floatChildren(itemContainer!)
    }
    /**
     * Takes care of adding items to the itemContainer at a specific index
     */
    func addItemAt(item:NSView,_ index:Int){
        itemContainer!.addSubviewAt(item, index)
        ElementModifier.floatChildren(itemContainer!)
    }
    /**
     * Takes care of removing items to the itemContainer at a specific index
     */
    func removeAt(index:Int){
        itemContainer!.removeSubviewAt(index)
        ElementModifier.floatChildren(itemContainer!)
    }
    /**
     * Simulates what happens when the user clicks on the CheckBox instanance
     * NOTE: this method is used in conjunction with the explode method
     */
    func open(){
        Swift.print("TreeListItem.open()")
        setChecked(true)
        checkBox?.onEvent(CheckEvent(CheckEvent.check, true, checkBox!))
    }
    /**
     * Simulates what happens when the user clicks on the CheckBox instanance
     * NOTE: this method is used in conjunction with the collapse method
     */
    func close(){
        Swift.print("TreeListItem.close()")
        setChecked(false)
        checkBox?.onEvent(CheckEvent(CheckEvent.check, false, checkBox!))
    }
    /**
     * event handler
     */
    func onItemCheck(event : CheckEvent) {
        //Swift.print("TreeListItem.onItemCheck() !event.isChecked: " + "\(!event.isChecked)")
        if((event.origin as! NSView).superview === self){itemContainer!.hidden = !event.isChecked}/*Checks if its this.checkButton is dispatching the event*///for (var i : int = 0; i < _itemContainer.numChildren; i++) (_itemContainer.getChildAt(i) as DisplayObject).visible = event.checked;
        if(event.isChecked) {ElementModifier.floatChildren(itemContainer!)}/*this is called from any decending treeListItem*/
    }
    /**
     * event listeners
     */
    override func onEvent(event:Event) {
        super.onEvent(event)
        if(event.type == CheckEvent.check){onItemCheck(event as! CheckEvent)}/*this listens to all treeListItem decendants*/
    }
    func getCount()->Int{
        return itemContainer!.subviews.count
    }
    override func getHeight() -> CGFloat {
        //Swift.print("TreeListItem.getHeight(): ")
        var height:CGFloat = SkinParser.totalHeight2(skin!)/*<--if we use totalHeight here it creates an infinite call loop*/
        if(getChecked()) {
            for (var i : Int = 0; i < itemContainer!.subviews.count; i++) {
                height += SkinParser.totalHeight((itemContainer!.getSubviewAt(i) as! IElement).skin!)
            }
            //Swift.print("extraHeight: " + "\(extraHeight)")
        }
        return height
    }
    override func setSize(width:CGFloat, _ height:CGFloat){
        super.setSize(width,height)
        ElementModifier.size(itemContainer!, CGPoint(width,height))/*so that descendants is updated when the TreeList is resized*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}