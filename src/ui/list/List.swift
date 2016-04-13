import Cocoa
//SkinParser.width(skin) was used before to create the mask size
//SkinParser.height(skin) was used before to create the mask size
/**
 * @Note There is no setSize in this component, for this purpose create a dedicated component I.E: ResizeList.as
 * @Note ListParser and ListModifier are usefull utility classes
 * // :TODO: could List have a SelectGroup?
 * // :TODO: xml should be able to hold a propert named selected="true" and then the cooresponding Item should be selected
 * // :TODO: try to get rid of the lableContainer
 * // :TODO: try to make the mask an Element
 * // :TODO:  MultipleSelection could be implimented by creating a new Class like MultipleSelectionList, Other possible classes to make: CheckList, ToggleList etc
 */
class List:Element,IList{
    var itemHeight:CGFloat
    var dataProvider : DataProvider
    var lableContainer  : Container?
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ dataProvider:DataProvider? = nil, _ parent: IElement?, _ id: String? = "") {
        self.itemHeight = itemHeight;
        self.dataProvider = dataProvider != nil ? dataProvider!:DataProvider()
        super.init(width, height,parent,id)
        self.dataProvider.event = onEvent//Add event handler for the dataProvider
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    /**
     * Creates the components in the List Component
     */
    override func resolveSkin() {
        super.resolveSkin()
        lableContainer = addSubView(Container(20,20,self,"lable"))
        /*let section = *///addSubView(Section(width,height,self))
        //section
        Swift.print("dataProvider.items.count: " + "\(dataProvider.items.count)")
        //mergeAt(dataProvider.items, 0);
    }
    /**
     * Creates and adds items to the _lableContainer
     * // :TODO: possibly move into ListModifier, TreeList has its mergeAt in an Utils class see how it does it
     */
    func mergeAt(objects:[Dictionary<String,String>], _ index:Int){// :TODO: possible rename needed
        var i:Int = index;
        Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            Swift.print("getWidth(): " + "\(getWidth())")
            Swift.print("self.itemHeight: " + "\(self.itemHeight)")
            let item:SelectTextButton = SelectTextButton(getWidth(), self.itemHeight ,object["title"]!, false, self.lableContainer)
            //Swift.print("item: " + "\(item)")
            self.lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
    /**
     * // :TODO: you need to update the float of the lables after an update
     */
    func onDataProviderEvent(event:DataProviderEvent){
        switch(event.type){
            case DataProviderEvent.add: mergeAt(event.items, event.startIndex); break;/*This is called when a new item is added to the DataProvider instance*/
            case DataProviderEvent.remove: lableContainer!.removeSubviewAt(event.startIndex); break;/*This is called when an item is removed form the DataProvider instance*/
            case DataProviderEvent.removeAll: ViewModifier.removeAllOfType(lableContainer!, ISelectable.self/*<--this may not work, see your comparing protocol and class code*/); break;/*This is called when all item is removed form the DataProvider instance*/
            case DataProviderEvent.sort: DepthModifier.sortByList(lableContainer!,"text","title", dataProvider.items); break;/*This is called when the items in the DataProvider instance is sorted*/
            case DataProviderEvent.dataChange: /*Not implimented yet*/ break;/*This is called when the items in the DataProvider instance is sorted*/
            case DataProviderEvent.replace: /*This is called when an item is replaced from the DataProvider instance*/
                self.lableContainer!.removeSubviewAt(event.startIndex);
                mergeAt(event.items, event.startIndex);
                break;
            default:fatalError("event type not supported"); break;
        }
        ElementModifier.floatChildren(lableContainer!)/*this call re-floats the list items*/
    }
    /**
     * This is called when a item in the _lableContainer has dispatched the ButtonEvent.TRIGGER_DOWN event
     */
    func onUpInside(buttonEvent:ButtonEvent) {
        let selectedIndex:Int = self.lableContainer!.indexOf(buttonEvent.origin as! NSView)
        Swift.print("selectedIndex: " + "\(selectedIndex)")
        ListModifier.selectAt(self,selectedIndex);
        super.onEvent(ListEvent(ListEvent.select,selectedIndex,self))
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.immediate === lableContainer){// :TODO: should listen for SelectEvent here
            onUpInside(event as! ButtonEvent)
        }else if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    /**
     *
     */
    override func setSize(width : CGFloat, _ height : CGFloat) {
        super.setSize(width, height);
        //skin.setState(skin.state);
        //self.mask.setSize(width, height);
        ElementModifier.refresh(lableContainer!)//was SkinModifier.size(_lableContainer,  CGPoint(width,self.itemHeight));
    }
    /**
     * Returns "List"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType() -> String {
        return String(List)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


// Continue here: how did you solve the clipping issue in Element? can it be used to mask? make a mask test