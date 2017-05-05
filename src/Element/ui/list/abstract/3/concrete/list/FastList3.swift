import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: Add selectedIdx to the init arg list?
 */
class FastList3:ContainerView3,FastListable3{
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var dp:DataProvider/*data storage*/
    var itemSize:CGSize
    var dir:Dir
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
    override var contentSize:CGSize {get{return dir == .hor ? CGSize(dp.count * itemSize.width ,height) : CGSize(width ,dp.count * itemSize.height) } set{_ = newValue;fatalError("not supported");}}
    init(_ width:CGFloat, _ height:CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil,_ parent:IElement? = nil, _ id:String? = "", _ dir:Dir = .ver) {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        self.dir = dir
        super.init(width,height,parent,id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        let visibleRange:Range<Int> = visibleItemRange/*Visible ItemRange Within View, calcs visibleItems based on lableContainer.y and height*/
        let range:Range<Int> = visibleRange.start..<min(dp.count,visibleRange.end)/*clip the range*/
        renderItems(range)
    }
    /**
     * Apply new data / align items
     * NOTE: ⚠️️ override this to use custom ItemList items
     */
    func reUse(_ listItem:FastListItem){
        //let item:SelectTextButton = listItem.item as! SelectTextButton
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        if let selectable = listItem.item as? ISelectable {
            let selected:Bool = idx == selectedIdx
            if selectable.selected != selected{
                selectable.setSelected(selected)//only set this if the selected state is different from the current selected state in the ISelectable
            }
        }
        if let textButton = listItem.item as? LableKind, let dpItem = dp.item(idx), let title:String = dpItem["title"]{
            textButton.setTextValue(title)
        }
        listItem.item.point[dir] = listItem.idx * itemSize[dir]/*position the item*/
    }
    /**
     * CreatesItem
     * NOTE: override this to create custom ListItems
     */
    func createItem(_ index:Int) -> Element{
        //Swift.print("⚠️️ FastList.createItem index: " + "\(index)")
        let item:SelectTextButton = SelectTextButton(itemSize.width, itemSize.height ,"", false, contentContainer)
        contentContainer!.addSubview(item)
        return item
    }
    override func onEvent(_ event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin.superview === contentContainer){onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        else if(event is DataProviderEvent){onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        Swift.print("FastList3.onListItemUpInside()")
        let viewIndex:Int = contentContainer!.indexOf(buttonEvent.origin as! NSView)
        List3Modifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        selectedIdx = FastList3Parser.idx(self, buttonEvent.origin as! NSView) ?? selectedIdx
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))/*if selectedIdx is nil then use -1 in the event*///TODO: probably use FastListEvent here in the future
    }
    override func getClassType() -> String {
        return dir == .ver ? "\(List.self)" : "VList"//<--VList really? isn't it more like HList atleast?
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension FastList3{
    /**
     * DP has changed
     * override this method if dp change can affect the super class
     * NOTE: event contains the range of the affected fastlist items. as long as we reflect this change everything will be synced
     * TODO: ⚠️️ It could be that you could make this method more effective. say if only data changes!?!?
     */
    func onDataProviderEvent(_ event:DataProviderEvent){
        Swift.print("FastList3.onDataProviderEvent: " + "\(event)")
        Swift.print("event.startIndex: " + "\(event.startIndex)")
        alignContentContainer(event)/*aligns the container*/
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        Swift.print("currentVisibleItemRange: " + "\(currentVisibleItemRange)")
        Swift.print("visibleItemRange: " + "\(visibleItemRange)")
        Swift.print("range: " + "\(range)")
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            Swift.print("🎨 render: \(event.startIndex) ")
            renderItems(range)/*the visible range has changed, render it*/
            pool.forEach{
                Swift.print("$0.idx: " + "\($0.idx)")
            }
            reUseFromIdx(event.startIndex)//quickfix, the permanent solution would be to only use this if there is a gap that wont get reused etc.
        }else{
            Swift.print("♲ reUse")
            reUseFromIdx(event.startIndex)/*the visible range hasn't changed, but the data has changed, apply new data*/
        }
    }
}
