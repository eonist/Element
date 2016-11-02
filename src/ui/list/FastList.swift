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
 * TODO: the dataProvider.items.count should probably be cached if the count is high, maybe even do this in the dataprovider it self
 * TODO: try the 1 loop setProgress idea (where you do the adding and appending the same place where you do the hiding)
 * TODO: test if resize works, by spawning new items etc
 */
typealias ListItem = (item:Element, idx:Int)/*Alias for the Duplet used to store list items and indecies*/
class FastList:Element,IList {
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data stoarge*/
    var lableContainer:Container?/*holds the list items*/
    let maxVisibleItems:Int/*this will be calculated on init and on setSize calls*/
    var itemsHeight:CGFloat {return dataProvider.items.count * itemHeight}//<--the tot items height can be calculated at init, and on list data refresh
    var surplusItems:[ListItem] = []/*repurpouse Items instead of removing and creating new ones*/
    var visibleItems:[ListItem] = []/*Item's that are within the mask, since itemContainer has surplus items and visible items we need this array to hold visible items*/
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = CGFloat.NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil) {
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        maxVisibleItems = ceil(height / itemHeight).int + 1
        Swift.print("maxVisibleItems: " + "\(maxVisibleItems)")
        super.init(width, height, parent, id)
        self.dataProvider.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame*///mask 100x400
    }
    override func resolveSkin() {
        Swift.print("FastList.resolveSkin()")
        Swift.print("itemsHeight: " + "\(itemsHeight)")
        super.resolveSkin()
        lableContainer = addSubView(Container(width,height,self,"lable"))
        spawn(0...maxVisibleItems)
        setProgress(0)/*<-not really needed, but nice to have while debugging*/
    }
    /**
     * PARAM: progress: 0 to 1
     * NOTE: why the complicated code in this method? Keep in mind that we must support going from progress: 0.1 to 0.9 in one cycle, which then recreates all items basically
     * TODO: An idea would be to append when items are above top limit, and prepend if items are bellow bottom limit, this would lead to simpler code and 1 less for loop
     */
    func setProgress(progress:CGFloat){
        let listY:CGFloat = -ListModifier.scrollTo(progress, height, itemsHeight)//we need the positive value
        //Swift.print("listY: " + "\(listY)")
        var i:Int = 0/*<--we can't use "for in" loop here because we alter visibleItems as we iterate,forEach works but while seems more apropriate,c-style for loop is the intention but is going away in swift3*/
        while(i < visibleItems.count){/*remove items that are above or bellow the limits*/
            let listItem:ListItem = visibleItems[i]
            if(listItem.idx*itemHeight <= listY - itemHeight || listItem.idx*itemHeight > listY + height){/*above top limit or bellow limit*/
                //Swift.print("item is above top or bellow bottom limit - remove()")
                Utils.hide(listItem.item, true)
                surplusItems += visibleItems.removeAtIndex(i)
            }
            i++
        }
        //Swift.print("visibleItems.count: " + "\(visibleItems.count)")
        //Swift.print("surplusItems.count: " + "\(surplusItems.count)")
        let firstItemIndex:Int = floor(abs(listY / itemHeight)).int//find the first item
        //Swift.print("firstItemIndex: " + "\(firstItemIndex)")
        let firstVisibleIdx:Int? = visibleItems.first?.idx// ?? firstItemIndex//first of the items that wasn't deleted
        //Swift.print("firstVisibleIdx: " + "\(firstVisibleIdx)")
        let lastVisibleIdx:Int? = visibleItems.last?.idx// ?? firstItemIndex+maxVisibleItems//last of the items that wasn't deleted
        //Swift.print("lastVisibleIdx: " + "\(lastVisibleIdx)")
        var firstPart:[ListItem] = []
        var thirdPart:[ListItem] = []
        let topY:CGFloat =  -(listY % itemHeight)//the y pos of the first item//visibleItems.first!.virtualY - listY/*By setting the items to the bottom of the above item, we avoid gaps that may apear*///let temp:CGFloat =  (firstItemIndex * 50) - listY
        var y:CGFloat = topY//
        var curVisibleItemIdx:Int = 0
        
        for i in 0..<maxVisibleItems{//append or prepend? back to the triple looping idea?
            let idx:Int = firstItemIndex + i
            if(idx >= 0 && idx < dataProvider.items.count){//<--avoids adding items when outside the range 0...<items.count, this can happen for instance if you use a RubberBandList
                //let listItem:ListItem
                if(firstVisibleIdx != nil && idx < firstVisibleIdx){//basiccally idx is less than firstVisible item, so we spoof a new one and place it at the top of the stack
                    //Swift.print("prepend (idx < first Visible Item)")
                    firstPart.append(reveal(idx,y))
                }else if(lastVisibleIdx != nil && idx > lastVisibleIdx){//basically idx is more than the last visible item
                    //Swift.print("append (idx > last Visible Item)")
                    thirdPart.append(reveal(idx,y))
                }else if(firstVisibleIdx == nil && lastVisibleIdx == nil){//no pre exisiting items exist,this only happens if no visible items exists
                    //Swift.print("append")//append
                    visibleItems.append(reveal(idx,y))
                }else{
                    visibleItems[curVisibleItemIdx].item.y = y
                    curVisibleItemIdx++
                }
                y += itemHeight/*increment the y value*/
            }
        }
        visibleItems = firstPart + visibleItems + thirdPart/*combine the arrays together*/
    }
    /**
     * Unhides, sets y, sets index (Its more convenient to do it in a method as the same code is in 3 places)
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
            let item:Element = spawn(i) as! Element
            visibleItems.append((item,i))
            lableContainer!.addSubView(item)
            item.y = y
            y += itemHeight
        }
    }
    /**
     * PARAM: idx: the index that coorespond to data items (spawn == create something)
     */
    func spawn(idx:Int)->NSView{
        let title:String = dataProvider.items[idx]["title"]!
        let selected:Bool = dataProvider.items[idx]["selected"]!.bool
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,title, selected, lableContainer)
        return item
    }
    /**
     * Applies data to items (spoof == reuse)
     */
    func spoof(listItem:(item:Element,idx:Int)){
        let item:Element = listItem.item
        let idx:Int = listItem.idx
        let title:String = dataProvider.items[idx]["title"]!
        let selected:Bool = dataProvider.items[idx]["selected"]!.bool
        (item as! ISelectable).setSelected(selected)
        (item as! SelectTextButton).setTextValue(title)
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(buttonEvent:ButtonEvent) {
        let selectedIndex:Int = lableContainer!.indexOf(buttonEvent.origin as! NSView)
        //Swift.print("selectedIndex: " + "\(selectedIndex)")
        FastListModifier.select(self,selectedIndex,true)
        super.onEvent(ListEvent(ListEvent.select,selectedIndex,self))
    }
    override func onEvent(event:Event) {
        if(event.type == ButtonEvent.upInside && event.immediate === lableContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    /**
     * So that we can use the List .css styles
     */
    override func getClassType() -> String {
        return String(List)
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
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
/**
 * TODO: Try to move the index in an array instead of creating ListItem, this way we can use any Element ype we wish
 */
/*
class ColorItem:Element{
    var virtualY:CGFloat {return index * height}
    var index:Int//we store the index in the item
    init(_ width: CGFloat, _ height: CGFloat, _ index:Int, _ parent: IElement?, _ id: String? = nil) {
        self.index = index
        super.init(width, height, parent, id)
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
*/

/*
private class ColorList{
    func spoof(listItem:(item:Element,idx:Int)){
        let item:Element = listItem.item
        let color:NSColor = items[listItem.idx]//item.index < items.count ? items[item.index] : NSColor.grayColor()//<--temp bug fix
        let style:IStyle = StyleModifier.clone(item.skin!.style!,item.skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var styleProperty = style.getStyleProperty("fill",0) /*edits the style*/
        if(styleProperty != nil){
            styleProperty!.value = color
            item.skin!.setStyle(style)/*updates the skin*/
        }
    }
}
*/
/*
itemContainer?.subviews.forEach{//remove items that are above or bellow the limits
    let item:ListItem = $0 as! ListItem
    if(item.virtualY < listY - 50){
        //Swift.print("item is above top limit - remove()")
        item.hidden = true
    }else if(item.virtualY > listY + height){
        //Swift.print("item is bellow bottom limit - remove()")
        item.hidden = true
    }else{
        item.y = item.virtualY - listY
        item.hidden = false
    }
    
}


*/


//Continue here: (This is the solution)
//make a method that can move an array of items to a progress value (then all you need to do is spoof the items that are different from last progress)
    //regardless of y offset
        //to accomplish this

//you get a value between 0 and 50 to determine when to reorder the view list
    //if topY > 25px -> move

//New idea: The idea is basically to just carousel a 9 item list, and apply data to the parts that are new when needed
    //you iterate 0..(8+1)
    //if curIdx = 45 -> 50 % curIdx -> 2
        //basically 2 leftover 
        //offset the visible views by 2*-50
    //loop 8+1 item
        //if(y < top-50)
            //move item to bottom of the view

//The above idea is great, make a isolated test to test it
    //you need to store the order of the 9 item indecies
    //draw the idea on paper to get a clearer view of how to code this (or try to visualize it in your mind, its a good excersie to do)


//Imagine an infinite list where the numbers keep repeating from 0..8
    //you travel the list by progress * totItemsHeight
    //you find the item offset by doing pos.y % 50
    //you find the curIdx by doing floor(abs(pos.y /50)) -> 22
    //you find the idex of 0..8 by doing 22 % 8 -> 6 -> which means 6 should be the top item, then 6,7,8,0,1,2,3,4,5
    //you find the y value for each of the items above (simple)
    //the previouse order is 0..8 -> how do you arrange it to the above? -> you dont rearange the view order -> you could and it would be trivial if it was needed
    //how to spoof new data?
        //store the curProgressIdx
        //find the diff for prevProgressIdx and the curProgressIdx
        //if the diff is +2 then the two last indecies has changed and needs spoofing
        //if diff is -2 then the two first indcies has changed and needs spoofing
        //if diff is more or less than 8 -> then spoof all

    //Edge cases
    //If win resize then add more items to the array
        //recalc the maxVisible Items
        //which recalcs the repeating numbers, which won't work in scale
        //Think of something else

//Maybe you could use the center of the view and calc above items needed and bellow items needed
    //

//New idea:
    //you need to check if the first item is above topLimit
    //if first item is bellow topLimit -> add an item to the top of the list
    //same for bottomLimit

    //what if you use the loop method when the maxVisibleItemCount grows -> it would only work with less than dubble the size of the original
    //I think you need to draw to figure this out


//new idea 2: (add and remove)
    //add 8 items to view at progres 0
    //go to progress 0.6
    //find the top.y
    //assert every current items if they are bellow top.y and above bottom.y (this can be optimized later so you only check first and last item)
        //if they are not -> remove them
        //add new items from top.y or the last item in visible list
            //keep adding until item.y > bottom.y

    //when you remove an item you only hide it and add it to removedItems array
    //when you add items you attempt to get an item from removedItems array and then insert it in to the container and set the y and unhide it and spoof it with new data




//move a "virtual" list up and down by: (just by values) (see code for this in List.swift)
    //(the index of the item in the list) * itemHeight, represetnts the initY pos
    //when you move the "virtual" list up and down you add the .y value of the "virtual" list to every item
    //when an item is above the top or bellow the bottom of the mask, then remove it

//You need a way to spawn items when they should be spawned (see legacy code for insp)

//Basically 8 items can be viewable at the time (maxViewableItems = 8)
//VirtualList.y = -200 -> how many items are above the top? -> use modulo -> think variable size though

//Actually: store the visible item indecies in an array that you push and pop when the list goes up and down
    //This has the benefit that you only need to calc the height of the items in view (thinking about variable size support)
    //when an item goes above the top 
        //the index is removed from the visibleItemIndecies array (one could also use a range here )
        //if the last index in visibleItemIndecies < items.count 
            //append items[visibleItemIndecies.last+1] to visibleItemIndecies
        //item.removeFromSuperView()
        //spawn new Item from items(visibleItemIndecies.last)
        //place it at y:  visibleItems.last.y+visibleItems.last.height