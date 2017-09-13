import Cocoa
@testable import Utils

class List5:ContainerView5,Listable5 {
    var dp:DataProvider {get{return config.dp} set{config.dp = newValue}}
    var dir:Dir {get{return config.dir} set{config.dir = newValue}}
    var itemSize:CGSize {get{return config.itemSize} set{config.itemSize = newValue}}
    //
    override var contentSize:CGSize { return dir == .hor ? CGSize(dp.count * itemSize.width ,maskSize.h) : CGSize(maskSize.w ,dp.count * itemSize.height) }
  
    struct Config {//TODO: ⚠️️ can this be moved into an extension?
        var itemSize:CGSize,dp:DP,dir:Dir
        static let defaultConfig:Config = .init(itemSize:CGSize(0,0), dp:DP.init(), dir:.ver)
    }
    var config:Config
    
    init(config:Config = Config.defaultConfig, size: CGSize = CGSize(), id: String? = "") {
        self.config = config
        super.init(size: size, id: id)
        self.dp.event = onEvent/*Add event handler for the dataProvider*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    /**
     * Creates the components in the List Component
     */
    override func resolveSkin() {
        super.resolveSkin()
        mergeAt(dp.items, 0)
    }
    /**
     * Creates and adds items to the _lableContainer
     * TODO: ⚠️️ possibly move into ListModifier, TreeList has it's mergeAt in an Utils class see how it does it
     */
    func mergeAt(_ dictionaries:[[String:String]], _ index:Int){//TODO: possible rename to something better, placeAt? insertAt?
        var i:Int = index
        for dict:[String:String] in dictionaries {
            let item = createItem(dict,i)
            contentContainer.addSubviewAt(item, i+1)/*the first index is reserved for the List skin, what, this is not good! ⚠️️ ⚠️️ ⚠️️?*/
            i += 1
        }
    }
    /**
     * Overridable
     */
    func createItem(_ dict:[String:String], _ i:Int) ->  NSView{//TODO: ⚠️️ add throws here
        let dictItem:String = dict["title"] ?? {fatalError("err")}()
        let item:SelectTextButton = SelectTextButton(itemSize.width, itemSize.height ,dictItem, false)
        return item
    }
    override func getClassType() -> String {
        return dir == .ver ? "List" : "VList"//<--this is actually wrong, use HList instead. and correct the css name
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

