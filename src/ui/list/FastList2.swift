import Foundation

class FastList2:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var prevVisibleRange:Range<Int>?
    var visibleItems:[FastListItem] = []
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        Swift.print("dataProvider.count: " + "\(dataProvider!.count)")
        super.init(width, height, parent, id)
        self.dataProvider.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        //Swift.print("FastList2.resolveSkin()")
        super.resolveSkin()
        Swift.print("FastList2.height: " + "\(height)")
        maxVisibleItems = round(height / itemHeight).int + 1
        Swift.print("maxVisibleItems: " + "\(maxVisibleItems)")
        maxVisibleItems = round(height / itemHeight).int + 1
        lableContainer = addSubView(Container(width,height,self,"lable"))
        prevVisibleRange = 0..<maxVisibleItems!-1
        Swift.print("prevVisibleRange: " + "\(prevVisibleRange)")
        spawn(0..<maxVisibleItems!-1)
    }
    /**
     *
     */
    func setProgress(progress:CGFloat){
        Swift.print("FastList2.setProgress() ")
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let visibleItemsTop:CGFloat = NumberParser.minMax(-1*lableContainer!.y, 0, itemHeight * dataProvider.count - height)
        //Swift.print("visibleItemsTop: " + "\(visibleItemsTop)")
        //let visibleBottom:CGFloat = visibleItemsTop + height
        //Swift.print("visibleBottom: " + "\(visibleBottom)")
        //var topItemY:CGFloat {let remainder = visibleItemsTop % itemHeight;return visibleItemsTop-itemHeight+remainder}
        //Swift.print("topItemY: " + "\(topItemY)")
        let topItemIndex:Int = round(visibleItemsTop / itemHeight).int
        //topItemIndex = NumberParser.minMax(topItemIndex, 0, dataProvider.count-maxVisibleItems!)//clamp the num between min and max
        Swift.print("topItemIndex: " + "\(topItemIndex)")
        let bottomItemIndex:Int = topItemIndex + maxVisibleItems!
        //if(bottomItemIndex >= dataProvider.count){bottomItemIndex = dataProvider.count-1}
        //Swift.print("bottomItemIndex: " + "\(bottomItemIndex)")
        //Swift.print("topItemIndex: " + "\(topItemIndex)")
        let curVisibleRange:Range<Int> = topItemIndex..<bottomItemIndex
        //Swift.print("curVisibleRange: " + "\(curVisibleRange)")
        if(curVisibleRange != prevVisibleRange){//only set if it's not the same as prev range
            spoof(curVisibleRange)/*spoof items in the new range*/
            prevVisibleRange = curVisibleRange
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(cur:Range<Int>){
        Swift.print("cur: " + "\(cur)")
        let prev = prevVisibleRange!
        Swift.print("prev: " + "\(prev)")
        let diff = prev.start - cur.start
        Swift.print("diff: " + "\(diff)")
        if(abs(diff) >= maxVisibleItems){//spoof every item
            Swift.print("all")
            for i in 0..<visibleItems.count {visibleItems[i] = (visibleItems[i].item, cur.start + i);spoof(visibleItems[i])}
        }else if(diff.positive){//cur.start is less than prev.start
            Swift.print("prepend ")
            var items = visibleItems.splice2(visibleItems.count-diff, diff)//grab the end items
            for i in 0..<items.count {items[i] = (items[i].item, cur.start + i);spoof(items[i])}//assign correct absolute idx
            visibleItems = items + visibleItems/*prepend to list*/
        }else if(diff.negative){//cur.start is more than prev.start
            Swift.print("append")
            var items = visibleItems.splice2(0, -1*(diff))//grab items from the top
            //Swift.print("visibleItems.count: " + "\(visibleItems.count)")
            Swift.print("items.count: " + "\(items.count)")
            //Swift.print("cur.last: " + "\(cur.last)")
            //Swift.print("cur.end: " + "\(cur.end)")
            
            //its almost correct, try with shorter list to find the missing piece🏀 and think!!!
            
            for i in 0..<items.count {
                items[i] = (items[i].item, cur.end + i)
                spoof(items[i])
            }//assign correct absolute idx
            visibleItems += items/*append to list*/
        }
    }
    /**
     * (spoof == apply/reuse)
     */
    func spoof(listItem:FastListItem){
        if(listItem.idx >= 0 && listItem.idx < dataProvider.count){
            Swift.print("spoof.item(\(listItem.idx))")
            let item:SelectTextButton = listItem.item as! SelectTextButton
            let idx:Int = listItem.idx/*the index of the data in dataProvider*/
            let dpItem = dataProvider.items[idx]
            let title:String = dpItem["title"]!
            Swift.print("title: " + "\(title)")
            item.setTextValue(title)
            item.y = listItem.idx * itemHeight/*position the item*/
            //Swift.print("item.y: " + "\(item.y)")
        }
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
    override func getClassType() -> String {
        return String(List)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
