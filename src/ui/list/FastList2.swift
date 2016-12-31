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
        //let loopIndex:CGFloat = topItemIndex % maxVisibleItems!.cgFloat//the index in a repeating series of numbers
        
        //continue here:
            //you use the iterate + loop value between min and max method from legacy code 🏀 
        /*
        let clampedIndex:Int = IntParser.normalize(loopIndex.int, maxVisibleItems!)
        clampedIndex
        */
        
        //Range<Int>(loopIndex.int,loopIndex.int+maxVisibleItems!)
        
        let curVisibleRange:Range<Int> = Range<Int>(topItemIndex.int,topItemIndex.int+maxVisibleItems!)
        if(curVisibleRange != prevVisibleRange){//only set if it's not the same as prev range
             prevVisibleRange = curVisibleRange
            //spoof items in the new range
            
            
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
        }else if(diff.positive){//cur.start is less than prev.start
            //prepend N items to the visibleItems arr (from the bottom)
            let items = visibleItems.splice2(visibleItems.count-diff, diff)
            for (index,element) in items.enumerate(){
                element.idx = cur.start + index
            }
            visibleItems = items + visibleItems/*prepend*/
            //and position them
            //and add data from dp
        }else if(diff.negative){//cur.start is more than prev.start
            
            //append N items to the visibleItems arr (from the top)
                //and position them
                //and add data from dp
        }
    }
    /**
     *
     */
    func spoof(items:[FastListItem]){
        
    }
    /**
     *
     */
    func spoof(item:FastListItem){
        
    }
    /**
     * (spawn == create something)
     */
    func spawn(){
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
