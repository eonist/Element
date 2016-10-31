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
        
        var y:CGFloat = 0
        for i in 0..<maxVisibleItems+1{//we need an extra item to cover the entire
            //visibleItemIndecies.append(i)
            let item = spawn(i)
            itemContainer!.addSubView(item)
            item.y = y
            y += 50
        }
        //spawn 8 items,
        setProgress2(0)
        
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
        
        //figure out how many items needs to be spoofed
        let spoofCount:Int = currentVisibleItem - firstItemIndex
        
        //Are we overcomplicating?
            //
        
        currentVisibleItem = firstItemIndex
        let topY:CGFloat = listY % 50//the left over
        
        
        
        for i in firstItemIndex..<maxVisibleItems{
            //only spoof new data if the top item goes above the top
                //move the item to the bottom
            //only spoof new data if the bottom item goes bellow the bottom
                //move the item to the top
            
            
            
        }
    }
    
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
    
    
    func setProgress2(progress:CGFloat){
        let itemsHeight:CGFloat = items.count * 50//<--the tot items height can be calculated at init, and on list data refresh
        let listY:CGFloat = -ListModifier.scrollTo(progress, height, itemsHeight)//we need the positive value
        
        itemContainer?.subviews.forEach{//remove items that are above or bellow the limits
            let item:ListItem = $0 as! ListItem
            if(item.virtualY < listY - 50){
                item.removeFromSuperview()
            }else if(item.virtualY > listY + height){
                item.removeFromSuperview()
            }
        }
        let topY:CGFloat = 50 - (listY % 50)//the y pos of the first item

        
        //Continue here: you cant set the y for the items, you need to add when you remove, then you repositon with virtualY - listY or something
        
        itemContainer?.subviews.forEach{
            let item:ListItem = $0 as! ListItem
            item.y = item.virtualY - listY
        }
        
        let firstItemIndex:Int = floor(abs(listY / 50)).int//find the first item
        let firstExistingItemIdx:Int = (itemContainer?.subviews.first as? ListItem)?.index ?? firstItemIndex
        let lastExisitngItemIdx:Int = (itemContainer?.subviews.last as? ListItem)?.index ?? firstItemIndex + maxVisibleItems
        
        for i in firstItemIndex..<firstExistingItemIdx{
            spawn(i)
        }
        for i in 0..<9{
            
        }
        //maybe you store the index in the item, also see legacy code for tips
            //if you store the index, then you can disregard items if they are out of bounds
        
    }
    /**
     * PARAM: at: the index that coorespond to items
     */
    func spawn(at:Int)->NSView{
        let item:ListItem = ListItem(100,50,at,itemContainer,"item")
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
class ListItem:Element{
    var virtualY:CGFloat {return index * 50}
    var index:Int
    init(_ width: CGFloat, _ height: CGFloat, _ index:Int, _ parent: IElement?, _ id: String? = nil) {
        self.index = index
        super.init(width, height, parent, id)
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