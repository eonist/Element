import Cocoa
/**
 *
 */
class CheckTextButton:TextButton,ICheckable {
    var isChecked:Bool;
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
     * Sets the _isChecked variable (Toggles between two states)
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setChecked(isChecked:Bool) {
        self.isChecked = isChecked
        setSkinState(getSkinState())
    }
    
    
    func getSelected()->Bool{return isSelected}
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState();
    }
}
