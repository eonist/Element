import Cocoa
/**
 * @Note the dispatchments of TreeListEvent.change is used to tell ScrollTreeList to update its scrollbar
 * @Note Use Database to modify the treeList
 * @Note ITreeList doesnt have access to database because, TreeListItem doesnt have a database
 * // :TODO: display:none and display:inline in the css shoud take care of the hiding and revealing of the elements not a method in this class (figure out how to do this)
 * // :TODO: there is a bug when setting the margin of any Text in this class that you have to counter meassure with a negative padding, this should be resolved
 * // :TODO: Why does ITreeListItem need to extend ITreeList, why does TreeList need ITreeList in the first place?
 * // :TODO: it may be wise to remove some of the floatChildren method sprinkled around, and only float after creation and after an event?, if possible, remeber that floatChildren doesnt float descendents aswell? Maybe create a float Decendants method?
 * // :TODO: create a close method that removes all items and eventlisteners
 */
class TreeList:Element,ITreeList {
    var itemHeight : CGFloat
    var node : Node
    var itemContainer : Container?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ node:Node = Node(), _ parent : IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight;
        self.node = node
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        //Swift.print("TreeList.resolveSkin() width: " + "\(width)" + " height: " + "\(height)")
        
        StyleManager.addStyle("Button#special{fill:blue;float:left;clear:left;}")
        StyleManager.addStyle("SelectCheckBoxButton{float:left;clear:left;}")
        
        super.resolveSkin()
        itemContainer = addSubView(Container(width,height,self,"lable"))
        
        
        setXML(node.xml)
        /*
        let btn = itemContainer!.addSubView(Button(100,24,itemContainer,"special"))
        btn
        */
        
        /*
        let btn = itemContainer!.addSubView(Button(100,24,itemContainer,"special"))
        btn
        
        let btn3 = itemContainer!.addSubView(Button(100,24,itemContainer,"special"))
        btn3
        
        StyleManager.addStyle("Button#second{fill:red;float:left;clear:left;}")
        
        let btn2 = itemContainer!.addSubView(Button(100,24,itemContainer,"second"))
        btn2
        */
        
        //continue here: figure out whats going on with adding more than one item to the itemContainer
        
        /*
        let txtBtn = itemContainer!.addSubView(TextButton("hello",100,24,itemContainer,"specialTextButton"))
        txtBtn
        */
        
        //continue here: try to make a 
        
        /*
        let selectCheckBoxButton = SelectCheckBoxButton(100,24,"test",false,false,itemContainer,"specialCheckBoxButton")
        itemContainer!.addSubView(selectCheckBoxButton)
        */
    }
    /**
     *
     */
    func setXML(xml:NSXMLElement){
        Swift.print("setXML")
        //TreeListModifier.removeAll(self)/*clear the tree list first*/
        node.xml = xml
        TreeListUtils.treeItems(node.xml,self,CGPoint(width, itemHeight))/*Utils.treeItems(xml) and add each DisplayObject in treeItems*/
        //ElementModifier.floatChildren(itemContainer!)
    }
    /**
     * Adds an instance that impliments ITreeListItem to the itemContainer
     */
    func addItem(item:NSView){// :TODO: rename to add
        Swift.print("addItem() item: " + "\(item)")
        //let selectCheckBoxButton = SelectCheckBoxButton(100,24,"test",false,false,itemContainer,"specialCheckBoxButton")
        //itemContainer!.addSubView(selectCheckBoxButton)
        
        let txtBtn = itemContainer!.addSubView(SelectTextButton(100,24,"hello",false,itemContainer,"specialTextButton"))
        txtBtn
        
        //itemContainer!.addSubView(item)
        //ElementModifier.floatChildren(itemContainer!)
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
        let descendants:Array<ITreeList> = TreeListParser.descendants(self)
        let selectables:Array<ISelectable> = descendants.map {($0 as! ISelectable)}//<--temp solution this should ideally be handled by the descendant call
        let selected:ISelectable = event.origin as! ISelectable
        SelectModifier.unSelectAllExcept(selected, selectables)
    }
    private func onItemCheck(event:CheckEvent) {
        let index:Array<Int> = TreeListParser.index(self, (event.origin as! NSView).superview!)
        XMLModifier.setAttributeAt(node.xml, index, "isOpen",String(event.isChecked))
        ElementModifier.floatChildren(itemContainer!)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    private func onDatabaseRemoveAt(event:NodeEvent)  {
        TreeListModifier.removeAt(self, event.index)
        ElementModifier.floatChildren(itemContainer!)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    private func onDatabaseRemoveAll(event:NodeEvent){
        TreeListModifier.removeAll(self)
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    /**
     * @Note the idea is that the databaseevent.addAt is propogated up until the TreeList instance, then it looks at what index it came from, and tries to addAt that index
     * @Note the TreeList.addAt is for the internal workings of the Class, use TreeList.database.addAt to add new items
     */
    private func onDatabaseAddAt(event : NodeEvent) {
        //Swift.print("onDatabaseAddAt() "+ this);
        let parentIndex:Array = event.index.slice2(0,event.index.count-1)
        let parentTreeList:ITreeList = TreeListParser.itemAt(self, parentIndex) as! ITreeList//DisplayObjectParser.getAt(_itemContainer,event.index.slice(0,event.index.length-1)) as ITreeList;//this;//TreeListParser.itemAt(this,event.index) as ITreeList;
        let item:NSView = TreeListUtils.item(event.xml!, parentTreeList.itemContainer!, CGPoint(width, itemHeight))
        let itemIndex:Int = event.index[event.index.count-1]
        parentTreeList.addItemAt(item,itemIndex);/*We could use TreeListModifier.addAt(parentTreeList, index, item) here but since we already have the parent since we need it when creating the item we can just use the addAt method directly*/
        ElementModifier.floatChildren(itemContainer!)/*Re aligns the entire treesturcture*/
        super.onEvent(TreeListEvent(TreeListEvent.change,self))
    }
    private func onDatabaseSetAttributeAt(event : NodeEvent) {
        TreeListModifier.setTitleAt(self, event.index, event.xml!["title"]!)
    }
    private func onBackgroundMouseClick(event:MouseEvent){
        //Swift.print("onBackgroundMouseClick");
        TreeListModifier.unSelectAll(self)
    }
    override func onEvent(event: Event) {
        if(event.type == CheckEvent.check && event.origin === itemContainer){onItemCheck(event as! CheckEvent)}
        else if(event.type == SelectEvent.select && event.origin === itemContainer){onItemSelect(event as! SelectEvent)}
        else if(event.type == NodeEvent.removeAt && event.origin === node){onDatabaseRemoveAt(event as! NodeEvent)}
        else if(event.type == NodeEvent.removeAll && event.origin === node){onDatabaseRemoveAll(event as! NodeEvent)}
        else if(event.type == NodeEvent.addAt && event.origin === node){onDatabaseAddAt(event as! NodeEvent)}
        else if(event.type == NodeEvent.setAttributeAt && event.origin === node){onDatabaseSetAttributeAt(event as! NodeEvent)}
        //TODO: you also need to implement: onBackgroundMouseClick when the skin of self is clicked
    }
    func getCount() -> Int{
        return itemContainer!.subviews.count
    }
    /**
     * Returns "TreeList"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType() -> String {
        return String(TreeList)
    }
    /**
     *
     */
    override func setSize(width:CGFloat, _ height:CGFloat){
        super.setSize(width,height);
        ElementModifier.size(itemContainer!, CGPoint(width,itemHeight));/*resizes all items in the itemContainer*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
