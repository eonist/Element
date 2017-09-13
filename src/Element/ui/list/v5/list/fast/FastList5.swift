import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Wouldnt it be better to extend ProgressableListView5?, I think fastList uses View not List 🤔
 */
class FastList5:ProgressableView5,FastListable5{
    //
    var selectedIdx:Int?/*This cooresponds to the "absolute" index in dp*/
    var dp:DataProvider {get{return config.dp} set{config.dp = newValue}}
    var dir:Dir {get{return config.dir} set{config.dir = newValue}}
    override var itemSize:CGSize {get{return config.itemSize} set{config.itemSize = newValue}}
    override var contentSize:CGSize { return dir == .hor ? CGSize(dp.count * itemSize.width ,maskSize.h) : CGSize(maskSize.w ,dp.count * itemSize.height) }
    //
    var config:List5.Config
    //
    var pool:[FastListItem] = []/*Stores the FastListItems*/
    var inActive:[FastListItem] = []/*Stores pool item that are not in-use*/
    //
    init(config:List5.Config = List5.Config.defaultConfig, size: CGSize = CGSize(), id: String? = "") {
        self.config = config
        super.init(size: size, id: id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer?.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        let visibleRange:Range<Int> = visibleItemRange/*Visible ItemRange Within View, calcs visibleItems based on lableContainer.y and height*/
        let range:Range<Int> = visibleRange.start..<min(dp.count,visibleRange.end)/*clip the range*/
        renderItems(range)
    }
    /**
     * Apply new data / align items
     * NOTE: ⚠️️ override this to use custom ItemList items, and remember to  set item position
     */
    func reUse(_ listItem:FastListItem){
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        if let selectable = listItem.item as? Selectable {
            let selected:Bool = idx == selectedIdx
            if selectable.selected != selected{
                selectable.setSelected(selected)//only set this if the selected state is different from the current selected state in the ISelectable
            }
        }
        if let textButton = listItem.item as? LableKind, let dpItem = dp.item(idx), let title:String = dpItem["title"]{
            textButton.setTextValue(title)
        }
        //disableAnim {}
        listItem.item.layer?.position[dir] = listItem.idx * itemSize[dir]/*position the item*/
    }
    /**
     * CreatesItem
     * NOTE: override this to create custom ListItems
     */
    func createItem(_ index:Int) -> Element{//TODO:⚠️️ return NSView not Element
        //Swift.print("⚠️️ FastList.createItem index: " + "\(index)")
        let item:SelectTextButton = SelectTextButton(itemSize.width, itemSize.height ,"", false, contentContainer)
        contentContainer.addSubview(item)//TODO: ⚠️️ consider not adding views here but in the caller instead
        return item
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, contentContainer) {onListItemUpInside(event as! ButtonEvent)}// :TODO: should listen for SelectEvent here
        else if event is DataProviderEvent {onDataProviderEvent(event as! DataProviderEvent)}
        super.onEvent(event)// we stop propegation by not forwarding events to super. The ListEvents go directly to super so they wont be stopped.
    }
    /**
     * This is called when a item in the lableContainer has send the ButtonEvent.upInside event
     */
    func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        Swift.print("FastList3.onListItemUpInside()")
        let viewIndex:Int = contentContainer.indexOf(buttonEvent.origin as! NSView)
        List5Modifier.selectAt(self,viewIndex)//unSelect all other visibleItems
        selectedIdx = FastList5Parser.idx(self, buttonEvent.origin as! NSView) ?? selectedIdx
        super.onEvent(ListEvent(ListEvent.select,selectedIdx ?? -1,self))/*if selectedIdx is nil then use -1 in the event*///TODO: probably use FastListEvent here in the future
    }
    override func getClassType() -> String {
        return dir == .ver ? "List" : "VList"//<--VList really? isn't it more like HList atleast?
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension FastList5{
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
        if currentVisibleItemRange != range {/*Optimization: only set if it's not the same as prev range*/
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
