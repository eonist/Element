import Foundation

class FastList2:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    
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
        let loopIndex:CGFloat = topItemIndex % maxVisibleItems!.cgFloat//the index in a repeating series of numbers
        //continue here:
            //you use the iterate + loop value between min and max method from legacy code 🏀
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
