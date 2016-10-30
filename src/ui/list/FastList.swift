import Cocoa

class FastList:Element {
    var visibleItems:[NSView] = []
    //var visibleItemIndecies:[Int] = []
    var items:[NSColor] = []
    var itemContainer:Container?
    let maxVisibleItems:Int = 8//this will be calculated on init and on setSize calls
    var currentVisibleItem:Int = 0//the current first visible item
    //var visibleRange:Range<Int> = Range<Int>(0,8)
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
        layer!.masksToBounds = true/*masks the children to the frame*///mask 100x400
    }
    override func resolveSkin() {
        super.resolveSkin()
        for _ in 0..<20{items.append(NSColor.random)}//Add 20 rects to a list (random colors) 100x50
        itemContainer = addSubView(Container(width,height,self,"itemContainer"))
        
        
        for i in 0..<maxVisibleItems+1{//we need an extra item to cover the entire
            //visibleItemIndecies.append(i)
            let item = spawn(i)
            itemContainer!.addSubView(item)
        }
        //spawn 8 items,
        setProgress(0)
        
        //Continue here: setup some prints to debug, then test it
    }
    /**
     * PARAM: progress: 0 to 1
     * NOTE: Supporting variable item height will require advance caching system for keeping track of item heights. The challenge is to not have to loop through 1000's of items to get the correct .y coordinate (remember setProgress may be called 60 times per second)
     */
    func setProgress(progress:CGFloat){
        let itemsHeight:CGFloat = items.count * 50//<--the tot items height can be calculated at init, and on list data refresh
        let listY:CGFloat = ListModifier.scrollTo(progress, height, itemsHeight)
        let firstItemIndex:Int = floor(abs(listY / 50)).int//find the first item
        
        //figure out how many 
        
        currentVisibleItem = firstItemIndex
        let topY:CGFloat = listY % 50//the left over
        var y:CGFloat = topY
        
        ViewModifier.removeAllChildren(itemContainer!)//temp solution -> may lead to memory leak -> in the future we should not delete the items but just reorder them and apply new values to the UI components,
        for i in firstItemIndex..<maxVisibleItems{
            //only spoof new data if the top item goes above the top
                //move the item to the bottom
            //only spoof new data if the bottom item goes bellow the bottom
                //move the item to the top
            
            let newItem = spawn(firstItemIndex+i)
            itemContainer!.addSubView(newItem)//add to the bottom
            newItem.y = y
            y += 50
        }
    }
    /**
     * PARAM: at: the index that coorespond to items
     */
    func spawn(at:Int)->NSView{
        let item:Element = Element(100,50,itemContainer,"item")
        return item
    }
    /**
     * Reuse item but apply new data
     */
    func spoof(at:Int,_ item:IElement){
        let color:NSColor = items[at]
        let style:IStyle = StyleModifier.clone(item.skin!.style!,item.skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var styleProperty = style.getStyleProperty("fill",0) /*edits the style*/
        if(styleProperty != nil){
            styleProperty!.value = color
            skin!.setStyle(style)/*updates the skin*/
        }
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}

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