import Foundation
@testable import Utils
class List4:Element{
    override func getClassType() -> String {
        return "List"
    }
}
class List3:ContainerView3,Listable3{
    var dp:DataProvider
    var dir:Dir
    var itemSize:CGSize
    override var contentSize:CGSize { get{return dir == .hor ? CGSize(dp.count * itemSize.width ,skinSize.h) : CGSize(skinSize.w ,dp.count * itemSize.height) } set{_ = newValue}}
    
    init(_ width: CGFloat, _ height: CGFloat, _ itemSize:CGSize = CGSize(NaN,NaN), _ dataProvider:DataProvider? = nil, _ dir:Dir = .ver, _ parent: ElementKind? = nil, _ id: String? = "") {
        self.itemSize = itemSize
        self.dp = dataProvider ?? DataProvider()/*<--if it's nil then a DB is created*/
        self.dir = dir
        super.init(size:CGSize(width,height), id:id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    /**
     * Creates the components in the List Component
     */
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("before merge")
//        Swift.print("dp.items: " + "\(dp.items)")
        mergeAt(dp.items, 0)
        Swift.print("after merge")
    }
    /**
     * Creates and adds items to the _lableContainer
     * TODO: possibly move into ListModifier, TreeList has its mergeAt in an Utils class see how it does it
     */
    func mergeAt(_ dictionaries:[[String:String]], _ index:Int){//TODO: possible rename to something better, placeAt? insertAt?
        var i:Int = index
        for dict:[String:String] in dictionaries {
            _ = createItem(dict,i)
            i += 1
        }
    }
    func createItem(_ dict:[String:String], _ i:Int) -> Element{
        let dictItem:String = dict["title"] ?? {fatalError("err")}()
        Swift.print("dictItem: " + "\(dictItem)")
        Swift.print("itemSize: " + "\(itemSize)")
        let item:SelectTextButton = SelectTextButton(itemSize.width, itemSize.height ,dictItem, false, contentContainer)
        Swift.print("item: " + "\(item)")
        Swift.print("contentContainer.numSubViews: " + "\(contentContainer.numSubViews)")
        Swift.print("contentContainer.subviews: " + "\(contentContainer.subviews)")
        contentContainer.addSubviewAt(item, i+1)/*the first index is reserved for the List skin, what?*/
        
        Swift.print("after add")
        return item
    }
    override func getClassType() -> String {
        return dir == .ver ? "List" : "VList"//<--this is actually wrong, use HList instead. and correct the css name
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
