import Cocoa
/**
 * This is a list that can support infinite list items, while still being fast, memory-convervative and responsive. To support 1000's of data items, just use DataProvider, To support millions, consider using a DataProvider that derive its data from a database (SQLite or other)
 * IMPORTANT: Only support for 1 itemHeight for now, see note about this bellow and how to work around it in the future
 * NOTE: Conceptually the first index is calculated with modulo, then subsecuent items have their index by adding 1
 * NOTE: Tearing in the graphics is caused by rapid adding and removing views, to avoid this rather hide views that are not visible, and move them into place when needed then unhide. Only create 1 surplus view for this purpouse. Hiding and revealing 1000 of items at once would hurt performance
 * NOTE: Another approach would be to use a really long view and shuffle items while we scroll, this seems superfluous though
 * NOTE: Placing items to the bottom of the above item is the only way to avoid gaps from apearing from time to time
 * NOTE: Supporting variable item height will require advance caching system for keeping track of item heights. The challenge is to not have to loop through 1000's of items to get the correct .y coordinate (remember setProgress may be called 60 times per second)
 * NOTE: When inserting list items at new indecies is needed, then update the dataprovider and it will in turn spoof the change visually
 * NOTE: to debug you can: remove the mask and use an outline that is above the itemContainer
 * NOTE: FastList supports select and unSelect w/o querrying dataProvider as dp is cpu intensive
 * TODO: the dataProvider.items.count should probably be cached if the count is high, maybe even do this in the dataprovider it self
 * TODO: try the 1 loop setProgress idea (where you do the adding and appending the same place where you do the hiding)
 * TODO: test if resize works, by spawning new items etc
 * TODO: Consider doing the really tall NSView idea because it might be faster and way simpler
 */
typealias FastListItem = (item:Element, idx:Int)/*Alias for the Tuple used to store list items and indecies*/
class FastList:Element,IList {
    var selectedIdx:Int?/*this cooresponds to the index in dp */
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var itemsCount:Int/*IMPORTANT: update this value if you update the count in dp, use events, ideally this should be handled in dp altogether*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var itemsHeight:CGFloat {return itemsCount * itemHeight}//<--TODO: the tot items height can be calculated at init, and on list data refresh
    var visibleItems:[FastListItem] = []/*Item's that are within the mask, since itemContainer has surplus items and visible items we need this array to hold visible items*/
    var surplusItems:[FastListItem] = []/*repurpouse Items instead of removing and creating new ones*/
    
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = CGFloat.NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil) {
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        itemsCount = dataProvider!.items.count
        super.init(width, height, parent, id)
        self.dataProvider.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame*///mask 100x400
    }
    override func resolveSkin() {
        Swift.print("FastList.resolveSkin()")
        super.resolveSkin()
        Swift.print("itemsHeight: " + "\(itemsHeight)")
        Swift.print("FastList.height: " + "\(height)")
        maxVisibleItems = round(height / itemHeight).int + 1
        Swift.print("maxVisibleItems: " + "\(maxVisibleItems)")
        lableContainer = addSubView(Container(width,height,self,"lable"))
        spawn(0..<maxVisibleItems!)
    }
    /**
     * PARAM: progress: 0 to 1
     * NOTE: why the complicated code in this method? Keep in mind that we must support going from progress: 0.1 to 0.9 in one cycle, which then recreates all items basically
     * TODO: An idea would be to append when items are above top limit, and prepend if items are bellow bottom limit, this would lead to simpler code and 1 less for loop (so removing and appending in the same for-loop, hover it will be harder to reason about) (another way to optimize this algo is to rebuild the component and use a long nsView, which will be easier to reason about and then apply virtual values later)
     * 1. set the virtualY to every item based on the progress
     * 2. remove and then shuffle items above and bellow on each iteration (like lego)
     * 
     * The concept is simple, you only show items that are within the limits as you scroll up and down. (these items only exists virtually, untill they are revealed if they are within the limits)
     * With these to rules: you should be able to create the algorithm that lay out items at a progress value
     * Stage.1: Remove items outside Limits
     * Stage.2: stack items to cover the visible area
     */
    func setProgress(progress:CGFloat){
        let listY:CGFloat = -ListModifier.scrollTo(progress, height, itemsHeight)//this is the list y offset, we add the substraction sign to get positive value
        //Swift.print("listY: " + "\(listY)")
        let topLimit:CGFloat = /*listY*/ -itemHeight
        //Swift.print("topLimit: " + "\(topLimit)")
        let bottomLimit:CGFloat = /*listY+*/ height
        //Swift.print("bottomLimit: " + "\(bottomLimit)")
        for var i = 0; i < visibleItems.count; ++i{/*Stage.1: Remove items outside Limits*/
            let listItem:FastListItem = visibleItems[i]
            let virtualY:CGFloat = listItem.idx*itemHeight - listY
            if(virtualY <= topLimit){/*above top limit*/
                //Swift.print("item: \(listItem.idx) at: \(virtualY) is above top limit")
                Utils.hide(listItem.item, true)
                surplusItems += visibleItems.removeAtIndex(i)
            }else if(virtualY >= bottomLimit){
                //Swift.print("item: \(listItem.idx) at: \(virtualY) is bellow bottom limit")
                Utils.hide(listItem.item, true)
                surplusItems += visibleItems.removeAtIndex(i)
            }else{
                //Swift.print("item: \(listItem.idx) is within at: \(virtualY)")
            }
        }
        //Swift.print("surplusItems.count: " + "\(surplusItems.count)")
        
        var firstPart:[FastListItem] = []
        var thirdPart:[FastListItem] = []
        //Swift.print("listY: " + "\(listY)")
        let firstItemIdx:Int = floor(listY / itemHeight).int.minMax(0, itemsCount - visibleItems.count)//find the "virtual" first item
        //Swift.print("firstItemIdx: " + "\(firstItemIdx)")
        let topY:CGFloat =  (firstItemIdx * itemHeight) - listY//the y pos of the first item//-(listY % itemHeight)
        //Swift.print("topY: " + "\(topY)")
        var y:CGFloat = topY/*By iterativly setting items to the bottom of the above item, we avoid gaps. Gaps can apear if we base the positioning on other types of calculation*/
        
        let firstVisibleItemIdx:Int = visibleItems.first?.idx ?? 0//if the visibleItems arr is empty then replenish it w/ items by appending items to thirdPart in the loop. This is triggered by setting this value to 0
        let lastVisibleItemIdx:Int = visibleItems.last?.idx ?? 0
        var visibleItemIdx:Int = 0
        for var i = 0; i < maxVisibleItems; ++i{/*Stage.2: stack items to cover the visible area*/
            let itemIdx:Int = (firstItemIdx + i)
            if(itemIdx < firstVisibleItemIdx && y > topLimit && itemIdx < itemsCount && surplusItems.count > 0){//1. item is above visibleItems, 2. y is bellow topLimit, 3. We make sure the index actually exist 4. make sure there is available items in surplus
                firstPart.append(reveal(itemIdx,y))
                //Swift.print("append to firstPart")
            }else if(itemIdx > lastVisibleItemIdx && y < bottomLimit && itemIdx < itemsCount && surplusItems.count > 0){//1. item is bellow visibleItems,2. y is above bottomLimit, 3. We make sure the index actually exist 4. make sure there is available items in surplus
                //Swift.print("append to thirdPart")
                thirdPart.append(reveal(itemIdx,y))
            }else if(visibleItemIdx < visibleItems.count){//item is visibleItem
                visibleItems[visibleItemIdx].item.y = y
                visibleItemIdx++
            }
            y += itemHeight
        }
        visibleItems = firstPart + visibleItems + thirdPart/*combine the arrays together*/
    }
    /**
     * Unhides, sets y, sets index (Its more convenient to do it in a method as the same code is in 2 places)
     * NOTE: This method is only called if surplusItems.count > 0
     */
    private func reveal(idx:Int, _ y:CGFloat) -> (item:Element,idx:Int){
        var listItem = surplusItems.removeAtIndex(0)
        listItem.idx = idx
        spoof(listItem)
        Utils.hide(listItem.item, false)
        listItem.item.y = y
        return listItem
    }
    /**
     * Creates the init items
     */
    private func spawn(range:Range<Int>){
        var y:CGFloat = 0
        for i in range{/*we need an extra item to cover the entire area*/
            //visibleItemIndecies.append(i)
            let item:Element = spawn(i)
            visibleItems.append((item,i))
            lableContainer!.addSubView(item)
            item.y = y
            y += itemHeight
        }
    }
    /**
     * Creates the items needed to cover the visible area. (This method will also be used when you resize the component, to add more items to cover the resized visible area)
     * PARAM: idx: the index that coorespond to data items (spawn == create something)
     * NOTE: Overide this method when you want to add your own Custom List Items (as long as the item extends Element)
     */
    func spawn(idx:Int)->Element{/*override this to use custom ItemList items*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,title, false, lableContainer)
        return item
    }
    /**
     * Applies data to a pre-exisiting item (spoof == apply/reuse)
     * NOTE: Overide this method when you want to add your own Custom List Items (as long as the item extends Element)
     */
    func spoof(listItem:FastListItem){/*override this to use custom ItemList items*/
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        if(item.selected != selected){ item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.setTextValue(title)
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(buttonEvent:ButtonEvent) {
        let viewIndex:Int = lableContainer!.indexOf(buttonEvent.origin as! NSView)
        ListModifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        visibleItems.forEach{if($0.item === buttonEvent.origin){selectedIdx = $0.idx}}/*We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self */
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))//probably use FastListEvent here in the future
    }
    /**
     * EventHandler for the items in the list
     * TODO: We should really use a SelectEvent here as SelectTextItem sends this event on ButtonEvent.upInside occurs
     */
    override func onEvent(event:Event) {
        if(event.type == ButtonEvent.upInside && event.immediate === lableContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    /**
     * So that we can use the List.css styles (This is because FastList doesn't extend List so we need to manually set the getClassType var)
     */
    override func getClassType() -> String {
        return String(List)
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     * Temp solution
     * NOTE: There is a more permanent way to disable animation with the actionForLayer, but it requires a change in InteractiveView etc
     * NOTE: maybe we can avoid hiding by just placing the view outside the mask item.y = top - item.height should to
     */
    static func hide(view:NSView, _ isHidden:Bool){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        //Change properties here without animation
        view.hidden = isHidden
        CATransaction.commit()
    }
}