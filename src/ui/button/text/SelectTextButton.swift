import Cocoa

class SelectTextButton:TextButton {
    var isSelected:Bool;
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    init(text : String = "defaultText", width : CGFloat, height : CGFloat, isSelected : Bool = false, parent : IElement? = nil, id : String? = nil){
        self.isSelected = isSelected;
        super.init(text, width, height, parent, id);
    }
    override func mouseUpInside(theEvent: NSEvent) {
        isSelected = true
        super.mouseUpInside(theEvent)
        NSNotificationCenter.defaultCenter().postNotificationName(SelectEvent.select, object:self)/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
    }
    /**
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(isSelected:Bool){
        self.isSelected = isSelected
        setSkinState(getSkinState());
    }
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState();
    }
}
