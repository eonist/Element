import Cocoa
@testable import Utils
/**
 * This is a list that can support infinite list items, while still being fast, memory-convervative and responsive. To support 1000's of data items, just use DataProvider, To support millions, consider using a DataProvider that derive its data from a database (SQLite or other)
 * NOTE: Supporting variable item height will require advance caching system for keeping track of item heights.📚 The challenge is to not have to loop through 1000's of items to get the correct .y coordinate (remember setProgress may be called 60 times per second)
 * NOTE: Conceptually the first index is calculated with modulo, then subsecuent items have their index by adding 1
 * NOTE: Flickering in the graphics is caused by rapid adding and removing views, to avoid this rather hide views that are not visible, and move them into place when needed then unhide. Only create 1 surplus view for this purpouse. Hiding and revealing 1000 of items at once would hurt performance
 * NOTE: We use a really long view and shuffle items while we scroll
 * NOTE: Supporting variable item height will require advance caching system for keeping track of item heights.📚 The challenge is to not have to loop through 1000's of items to get the correct .y coordinate (remember setProgress may be called 60 times per second)
 * NOTE: [].count is a stored property in swift, no need to cache .count even for mutable arrays thumbup 👍
 * IMPORTANT: Only support for 1 itemHeight for now, see note about this bellow and how to work around it in the future ✅
 * TODO: Add resize support (test if resize works, by spawning new items etc)
 */
typealias FastListItem = (item:Element, idx:Int)/*Alias for the Tuple used to store list items and "absolute" indecies*/

class FastList2:DisplaceView,IFastList2 {
    var _itemHeight:CGFloat//⚠️️ temp fix
    override var itemHeight:CGFloat {return _itemHeight}
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    //var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    //var lableContainer:Container?/*holds the list items*/
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
    
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self._itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        //layer!.masksToBounds = true/*masks the children to the frame*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        
        //lableContainer = addSubView(Container(width,height,self,"lable"))
        let visibleRange:Range<Int> = visibleItemRange/*visible ItemRange Within View, calcs visibleItems based on lableContainer.y and height*/
        let range:Range<Int> = visibleRange.start..<min(dp.count,visibleRange.end)/*clip the range*/
        renderItems(range)
    }
    
    /**
     * Apply new data / align items
     * NOTE: override this to use custom ItemList items
     */
    func reUse(_ listItem:FastListItem){
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        if(item.selected != selected){ item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.setTextValue(idx.string + " " + title)
        item.y = listItem.idx * itemHeight/*position the item*/
    }
    /**
     * CreatesItem
     * NOTE: override this to create custom ListItems
     */
    func createItem(_ index:Int) -> Element{
        Swift.print("createItem index: " + "\(index)")
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,"", false, lableContainer)
        lableContainer!.addSubview(item)
        return item
    }
    /**
     * DP has changed
     * override this method if dp change can affect the super class
     */
    func onDataProviderEvent(_ event:DataProviderEvent){
        alignLableContainer(event)
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)/*the visible range has changed, render it*/
        }else{
            reUseFromIdx(event.startIndex)/*the visible range hasn't changed, but the data has changed, apply new data*/
        }
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        let viewIndex:Int = lableContainer!.indexOf(buttonEvent.origin as! NSView)
        fatalError("⚠️️ uncomment the line bellow, debug only")
        //ListModifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        pool.forEach{if($0.item === buttonEvent.origin){selectedIdx = $0.idx}}/*We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies*/
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))/*if selectedIdx is nil then use -1 in the event*///TODO: probably use FastListEvent here in the future
    }
    override func onEvent(_ event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin.superview === lableContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        else if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    override func getClassType() -> String {return "\(List.self)"}
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
