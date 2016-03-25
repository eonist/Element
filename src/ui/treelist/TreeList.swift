import Cocoa
/**
 * // :TODO: display:none and display:inline in the css shoud take care of the hiding and revealing of the elements not a method in this class (figure out how to do this)
 * // :TODO: there is a bug when setting the margin of any Text in this class that you have to counter meassure with a negative padding, this should be resolved
 * // :TODO: Why does ITreeListItem need to extend ITreeList, why does TreeList need ITreeList in the first place?
 * // :TODO: it may be wise to remove some of the floatChildren method sprinkled around, and only float after creation and after an event?, if possible, remeber that floatChildren doesnt float descendents aswell? Maybe create a float Decendants method?
 * // :TODO: create a close method that removes all items and eventlisteners
 */
class TreeList:Element/*,ITreeList*/ {
    var itemHeight : CGFloat
    var node : Node
    var itemContainer : Container?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ node:Node = Node(), _ parent : IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight;
        self.node = node
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        itemContainer = addSubView(Container(width,height,self))
        //setXML(node.xml)
    }
    /**
     * Adds an instance that impliments ITreeListItem to the itemContainer
     */
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
    private func onItemSelect(event:SelectEvent){// :TODO: make protected since we may want to have differ functionality, like multi select
        //var selectables:Array = TreeListParser.descendants(self);
        //var selected:ISelectable = event.origin as! ISelectable
        //SelectModifier.unSelectAllExcept(selected, selectables);
    }
    private func onItemCheck(event:CheckEvent) {
        //var index:Array = TreeListParser.index(self, (event.target as DisplayObject).parent);
        //XMLModifier.setAttributeAt(node.xml, index, ["isOpen":String(event.checked)])
        ElementModifier.floatChildren(itemContainer!)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    private func onDatabaseRemoveAt(event:NodeEvent)  {
        //TreeListModifier.removeAt(self, event.index)
        ElementModifier.floatChildren(itemContainer!)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    private func onDatabaseRemoveAll(event:NodeEvent){
        //TreeListModifier.removeAll(self)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    /**
     *
     */
    func setXML(xml:NSXMLElement){
        Swift.print("setXML")
        //TreeListModifier.removeAll(self)/*clear the tree list first*/
        node.xml = xml
        //TreeListUtils.treeItems(node.xml,self,CGPoint(width, itemHeight))/*Utils.treeItems(xml) and add each DisplayObject in treeItems*/
        ElementModifier.floatChildren(itemContainer!)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
