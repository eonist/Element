import Foundation

class FastList2:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var prevVisibleRange:Range<Int> = Range<Int>(0,0)
    var visibleItems:[FastListItem] = []
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        
        super.init(width, height, parent, id)
        self.dataProvider.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        lableContainer = addSubView(Container(width,height,self,"lable"))
        maxVisibleItems = round(height / itemHeight).int + 1
    }
    /**
     *
     */
    func setProgress(progress:CGFloat){
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let visibleItemsTop:CGFloat = abs(lableContainer!.y)
        let visibleBottom:CGFloat = visibleItemsTop + height
        var topItemY:CGFloat {let remainder = visibleItemsTop % itemHeight;return visibleItemsTop-itemHeight+remainder}
        //let itemsHeight:CGFloat = (itemHeight * dataProvider.count)
        let topItemIndex:CGFloat = floor(visibleItemsTop / itemHeight)
        let curVisibleRange:Range<Int> = Range<Int>(topItemIndex.int,topItemIndex.int+maxVisibleItems!)
        if(curVisibleRange != prevVisibleRange){//only set if it's not the same as prev range
            prevVisibleRange = curVisibleRange
            spoof(curVisibleRange)/*spoof items in the new range*/
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(cur:Range<Int>){
        let prev = prevVisibleRange
        let diff = prev.start - cur.start
        if(abs(diff) >= maxVisibleItems){
            //spoof every item
            for i in 0..<visibleItems.count {visibleItems[i] = (visibleItems[i].item, cur.start + i);spoof(visibleItems[i])}
        }else if(diff.positive){//cur.start is less than prev.start
            var items = visibleItems.splice2(visibleItems.count-diff, diff)//grab the end items
            for i in 0..<items.count {items[i] = (items[i].item, cur.start + i);spoof(items[i])}//assign correct absolute idx
            visibleItems = items + visibleItems/*prepend to list*/
        }else if(diff.negative){//cur.start is more than prev.start
            var items = visibleItems.splice2(0, abs(diff))//grab items from the top
            for i in 0..<items.count {items[i] = (items[i].item, cur.end + i);spoof(items[i])}//assign correct absolute idx
            visibleItems += items/*append to list*/
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(listItem:FastListItem){
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
            //visibleItemIndecies.append(i)
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
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let item:SelectTextButton = SelectTextButton(getWidth(), itemHeight ,title, false, lableContainer)
        return item
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
