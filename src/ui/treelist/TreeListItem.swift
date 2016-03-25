import Foundation
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
    public function addItem(item:DisplayObject):void{// :TODO: possibly add an addItems function to facilitate  align()
    _itemContainer.addChild(item);
    if(checked) ElementModifier.floatChildren(_itemContainer);
    }
    public function addItemAt(item:DisplayObject,index:int):void{// :TODO: possibly add to TreeListModifier
    _itemContainer.addChildAt(item, index);/*used to be DisplayObjectModifier.addAt(_itemContainer, item, index);*/
    if(checked) ElementModifier.floatChildren(_itemContainer);
    }
    public function removeAt(index:int):void{
    _itemContainer.removeChildAt(index);
    ElementModifier.floatChildren(_itemContainer);
    }
    
    
    func addItem(item:NSView){// :TODO: rename to add
        itemContainer!.addSubView(item)
        ElementModifier.floatChildren(itemContainer!)
    }
    func addItemAt(item:NSView,_ index:Int){// :TODO: rename to addAt
        itemContainer!.addSubviewAt(item, index)/*used to be DisplayObjectModifier.addAt(_itemContainer, item, index);*/
        ElementModifier.floatChildren(itemContainer!)
    }
    func removeAt(index:Int){
        itemContainer!.removeSubviewAt(index)
        ElementModifier.floatChildren(itemContainer!)
    }
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}