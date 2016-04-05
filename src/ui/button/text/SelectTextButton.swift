import Cocoa
/**
 * NOTE: Maybe the methods relating to ISelectable could be moved to an extension (Maybe not, since you need access to super, test this idea in playground)
 */
class SelectTextButton:TextButton,ISelectable {
    var isSelected:Bool;
    init(_ width : CGFloat, _ height : CGFloat, _ text : String = "defaultText", _ isSelected : Bool = false, _ parent : IElement? = nil, _ id : String? = nil){
        self.isSelected = isSelected;
        super.init(width, height, text, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func mouseUpInside(event: MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)
        //NSNotificationCenter.defaultCenter().postNotificationName(SelectEvent.select, object:self)/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
        self.event!(SelectEvent(SelectEvent.select,self/*,self*/))
    }
    /**
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(isSelected:Bool){
        self.isSelected = isSelected
        setSkinState(getSkinState());
    }
    func getSelected()->Bool{return isSelected}
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState();
    }
}
