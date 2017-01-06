import Foundation

class FastList3:Element,IList{
    var itemHeight:CGFloat/*The list item height, each item must have the same height*/
    var dataProvider:DataProvider/*data storage*/
    var lableContainer:Container?/*holds the list items*/
    var maxVisibleItems:Int?/*this will be calculated on init and on setSize calls*/
    var prevVisibleRange:Range<Int>?
    var visibleItems:[FastListItem] = []
    init(_ width:CGFloat, _ height:CGFloat, _ itemHeight:CGFloat = NaN,_ dataProvider:DataProvider? = nil, _ parent:IElement?, _ id:String? = nil){
        self.itemHeight = itemHeight
        self.dataProvider = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        super.init(width, height, parent, id)
        self.dataProvider.event = self.onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        maxVisibleItems = round(height / itemHeight).int
        lableContainer = addSubView(Container(width,height,self,"lable"))
        let numOfItems:Int = Swift.min(maxVisibleItems!, dataProvider.count)
        prevVisibleRange = 0..<numOfItems//<--this should be the same range as we set bellow no?
        spawn(0..<numOfItems)
    }
    func setProgress(progress:CGFloat){
        ListModifier.scrollTo(self, progress)/*moves the labelContainer up and down*/
        let curVisibleRange:Range<Int> = Utils.curVisibleItems(self, maxVisibleItems!)
        if(curVisibleRange != prevVisibleRange){/*Optimization: only set if it's not the same as prev range*/
            spoof(curVisibleRange)/*spoof items in the new range*/
            prevVisibleRange = curVisibleRange
        }
    }
}