import Foundation
/**
 * @Note There is no setSize in this component, for this purpose create a dedicated component I.E: ResizeList.as
 * @Note ListParser and ListModifier are usefull utility classes
 * // :TODO: could List have a SelectGroup?
 * // :TODO: xml should be able to hold a propert named selected="true" and then the cooresponding Item should be selected
 * // :TODO: try to get rid of the lableCOntainer
 * // :TODO: try to make the mask an Element
 * // :TODO:  MultipleSelection could be implimented by creating a new Class like MultipleSelectionList, Other possible classes to make: CheckList, ToggleList etc
 */
class List : Element{
    private var itemHeight:CGFloat
    private var dataProvider : DataProvider
    private var lableContainer  : Container?
    
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ dataProvider:DataProvider? = nil, _ parent: IElement?, _ id: String? = "") {
        self.itemHeight = itemHeight;
        self.dataProvider = dataProvider != nil ? dataProvider!:DataProvider()
        super.init(width, height,parent,id)
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    /**
     * Creates the components in the List Component
     */
    override func resolveSkin() {
        super.resolveSkin()
        //lableContainer = addSubView(Container(width,height,self)) as? Container
        let section = addSubView(Section(width,height,self)) as? Section
        section
        _lableContainer.mask = _mask = addChild(new Rect2(SkinParser.width(skin)/*<-- use getWidth() ???*/,SkinParser.height(skin)/*SkinParser.totalHeight2(skin)*//*<---might be wrong*/,new FillStyle(0x000000))) as Rect2;// :TODO: use Rect3
        //mergeAt(_dataProvider.items, 0);
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


// Continue here: how did you solve the clipping issue in Element? can it be used to mask? make a mask test