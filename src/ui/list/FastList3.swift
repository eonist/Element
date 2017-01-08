import Foundation

class FastList3:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var prevVisibleRange:Range<Int>?
    var visibleItems:[FastListItem] = []//fastlistitem also stores the absolute integer that cooresponds to the db.item
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        //layer!.masksToBounds = true/*masks the children to the frame, I don't think this works...seem to work now*/
        
        //Next:
            //add a red rect above where the mask is
            //Add a blue rect above all the items in the itemContainer (use itemsHeight)
            //Add a green rect that represents the range to render (everything inside this rect must be rendered) (it goes in the itemContainer)
                //The green rect can never be 
            //Add a purple rect that represents the buffer area, 1-item above top and 1-item bellow bottom
        
        //Rules:
            //Always try to show 1 item above topLimit
            //Always try to show 1 item bellow bottomLimit
        
        //Tests:
            //Continusly and randomly try to add items to the list on repeate, while you scroll up and down
        
        //Ideas:
            //When you remove an item that falls outside the perimeter, then move it to the "pool"
            //if an item is not available in pool and you need it, then create a new one
            //Pool can only have 1 surplus item at the time, you dont want to hold many items that are not in use -> after resize for instance
            //Figure out the pooling in the context that db.count may change while scrolling🏀
                //only move items to buffer when it moves outside top or bottom limit
            //spoof(range) could use an array.diff method and genereate individual spoof(fastlistitem) that way
                
    }
    override func resolveSkin() {
        super.resolveSkin()
        maxVisibleItems = round(height / itemHeight).int
        lableContainer = addSubView(Container(width,height,self,"lable"))
        let numOfItems:Int = Swift.min(maxVisibleItems!+1, dataProvider.count)
        prevVisibleRange = 0..<numOfItems//<--this should be the same range as we set bellow no?
        spawn(0..<numOfItems)
    }
    func setProgress(progress:CGFloat){
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let curVisibleRange:Range<Int> = Utils.curVisibleItems(self, maxVisibleItems!+1)
        if(curVisibleRange != prevVisibleRange){/*Optimization: only set if it's not the same as prev range*/
            spoof(curVisibleRange)/*spoof items in the new range*/
            prevVisibleRange = curVisibleRange
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(cur:Range<Int>){
        let prev = prevVisibleRange!
        let diff = prev.start - cur.start
        if(abs(diff) >= maxVisibleItems!+1){//spoof every item
            Swift.print("all")
            for i in 0..<visibleItems.count {
                let idx = cur.start + i
                visibleItems[i] = (visibleItems[i].item, idx)
                spoof(visibleItems[i])
            }
        }else if(diff.positive){//cur.start is less than prev.start
            Swift.print("prepend ")
            var items = visibleItems.splice2(visibleItems.count-diff, diff)//grab the end items
            for i in 0..<items.count {items[i] = (items[i].item, cur.start + i);spoof(items[i])}//assign correct absolute idx
            visibleItems = items + visibleItems/*prepend to list*/
        }else if(diff.negative){//cur.start is more than prev.start
            Swift.print("append")
            var items = visibleItems.splice2(0, -1*(diff))//grab items from the top
            for i in 0..<items.count {
                items[i] = (items[i].item, prev.end + i)
                spoof(items[i])
            }//assign correct absolute idx
            visibleItems += items/*append to list*/
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(listItem:FastListItem){/*override this to use custom ItemList items*/
        Swift.print("spoof: " + "\(listItem.idx)")
        let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        item.setTextValue(title)
        item.y = listItem.idx * itemHeight/*position the item*/
    }
    /**
     * (spawn == create something)
     */
    private func spawn(range:Range<Int>){
        for i in range{/*we need an extra item to cover the entire area*/
            let item:Element = spawn(i)
            visibleItems.append((item,i))
            lableContainer!.addSubView(item)
            item.y = i * itemHeight
        }
    }
    /**
     * (spawn == create something)
     */
    func spawn(idx:Int)->Element{/*override this to use custom ItemList items*/
        Swift.print("spawn: " + "\(idx)")
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,title, false, lableContainer)
        return item
    }
    override func getClassType() -> String {return String(List)}
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     *
     */
    static func curVisibleItems(list:IList,_ maxVisibleItems:Int)->Range<Int>{
        let visibleItemsTop:CGFloat = abs(list.lableContainer!.y > 0 ? 0 : list.lableContainer!.y)//NumberParser.minMax(-1*lableContainer!.y, 0, itemHeight * dataProvider.count - height)
        //Swift.print("visibleItemsTop: " + "\(visibleItemsTop)")
        //let visibleBottom:CGFloat = visibleItemsTop + height
        //Swift.print("visibleBottom: " + "\(visibleBottom)")
        //var topItemY:CGFloat {let remainder = visibleItemsTop % itemHeight;return visibleItemsTop-itemHeight+remainder}
        //Swift.print("topItemY: " + "\(topItemY)")
        var topItemIndex:Int = (visibleItemsTop / list.itemHeight).int
        topItemIndex = topItemIndex < 0 ? 0 : topItemIndex
        //topItemIndex = NumberParser.minMax(topItemIndex, 0, dataProvider.count-maxVisibleItems!)//clamp the num between min and max
        //Swift.print("topItemIndex: " + "\(topItemIndex)")
        var bottomItemIndex:Int = topItemIndex + maxVisibleItems
        bottomItemIndex = bottomItemIndex > list.dataProvider.count-1 ? max(list.dataProvider.count-1,0) : bottomItemIndex//the max part forces the value to be no less than 0
        //if(bottomItemIndex >= dataProvider.count){bottomItemIndex = dataProvider.count-1}
        //Swift.print("bottomItemIndex: " + "\(bottomItemIndex)")
        //Swift.print("topItemIndex: " + "\(topItemIndex)")
        let curVisibleRange:Range<Int> = topItemIndex..<bottomItemIndex
        return curVisibleRange
    }
    /**
     * When you add/remove items from a list, the list changes size. This method returns a value that lets you keep the same position of the list after a add/remove items change
     * EXAMPLE: let p = progress(100, 500, 0, 700)//(200,0.5)
     */
    static func progress(maskHeight:CGFloat,_ newItemsHeight:CGFloat, _ oldLableContainerY:CGFloat, _ oldItemsHeight:CGFloat)->(lableContainerY:CGFloat,progress:CGFloat){
        if(oldLableContainerY >= 0){//this should be more advance, like assert wether an item was inserted in the visiblepart of the view, and position the list accordingly, to be continued
            let progress = SliderParser.progress(oldLableContainerY, maskHeight, oldItemsHeight)
            return (oldLableContainerY,progress)}/*pins the list to the top if its already at the top*/
        let newItemsHeight = newItemsHeight
        let dist = -(newItemsHeight-oldItemsHeight)//dist <-> old and new itemsHeight
        let newProgress = (oldLableContainerY+dist)/(-(newItemsHeight-maskHeight))
        let newLableContainerY = -(newItemsHeight-maskHeight)*newProgress
        return (newLableContainerY,newProgress)
    }
    
}