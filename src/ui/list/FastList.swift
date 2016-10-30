import Cocoa

class FastList:Element {
    var visibleItems:[NSView] = []
    var visibleItemIndecies:[Int] = []
    
    var items:[NSColor] = []
    var itemContainer:Container?
    let maxVisibleItems:Int = 8//this will be calculated on init and on setSize calls
    var visibleRange:Range<Int> = Range<Int>(0,8)
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        
        
        
        super.init(width, height, parent, id)
        //Add 20 rects to a list (random colors) 100x50
        //mask 100x400
       
        layer!.masksToBounds = true/*masks the children to the frame*/
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
    }
    override func resolveSkin() {
        super.resolveSkin()
        for _ in 0..<20{items.append(NSColor.random)}
        itemContainer = addSubView(Container(width,height,self,"itemContainer"))
        
        //Continue here:  then make the progress() method
        for i in 0..<maxVisibleItems{
            visibleItemIndecies.append(i)
            let item = spawn(i)
            itemContainer!.addSubView(item)
        }//spawn 8 items,
    }
    /**
     * PARAM: progress: 0 to 1
     */
    func setProgress(progress:CGFloat){
        let itemsHeight:CGFloat = items.count * 50//<--the tot items height can be calculated at init, and on list data refresh
        let listY:CGFloat = ListModifier.scrollTo(progress, height, itemsHeight)
        
        //Continue here: A problem: what if progress jumps from 0.1 to 0.9 
            //you need to derive the correct items for this dramatic change
            //but keep in mind that items may have different item heights, so you may need to derive the height to reflect this
                //the question becomes: how do do you find the correct position for the items
                    //Would you need to store all heights in the items array?
                    //or maybe you just calc the entier height and progress based on this height?
                        //but then how do you know which items to spawn at progress:0.6?
                        //the solution is to not support variable item.height
                            //To support variable item.height one could save the heights in items and then looping heights on y calculations
                            //Actually progress 0.6 of the totItemsHeight is actually: totHeight * 0.6 
                                //the challenge is to find the items covering this progress point
                                    //if you virtually place all items on item (by adding their .y in the items array)
                                    //
        //find the first item 
        var firstItemIndex:Int = floor(abs(listY / 50)).int
        
        //find the last item
        var lastItemIndex:Int = firstItemIndex + maxVisibleItems
        
        for i in 0..<maxVisibleItems{
            
        }
        
        
        var y:CGFloat = listY
        var len:Int = itemContainer!.subviews.count
        for var i = 0; i < len; ++i{//position the items
            let item:Element = itemContainer!.subviews[i] as! Element
            item.y = y
            if(item.y < -50){//above top
                item.removeFromSuperview()
                visibleItemIndecies.shift()//removes the first item from the list
                if(visibleItemIndecies.last < items.count){
                    let newItem = spawn(visibleItemIndecies.last!+1)
                    itemContainer!.addSubView(newItem)//add to the bottom
                    
                    len++
                }
            }else if(item.y > height){//bellow bottom
                item.removeFromSuperview()
            }
            y += 50
        }
    }
    /**
     * PARAM: at: the index that coorespond to items
     */
    func spawn(at:Int)->NSView{
        let color:NSColor = items[at]
        let item:Element = Element(100,50,itemContainer,"item")
        let style:IStyle = StyleModifier.clone(item.skin!.style!,item.skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var styleProperty = style.getStyleProperty("fill",0) /*edits the style*/
        if(styleProperty != nil){
            styleProperty!.value = color
            skin!.setStyle(style)/*updates the skin*/
        }
        return item
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
