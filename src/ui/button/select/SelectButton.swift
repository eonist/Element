import Cocoa

class SelectButton:Button,ISelectable {
    var isSelected:Bool
    init(_ width: CGFloat, _ height: CGFloat, _ isSelected : Bool = false, _ parent: IElement? = nil, _ id: String? = nil) {
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func mouseUpInside(event: MouseEvent) {
        //Swift.print("SelectButton.mouseUpInside()")
        isSelected = true
        super.mouseUpInside(event)
        //NSNotificationCenter.defaultCenter().postNotificationName(SelectEvent.select, object:self)/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
        self.event!(SelectEvent(SelectEvent.select,self))
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


//continue: get window working with float. then add radio bullets then post