import Cocoa

class CheckTextButton:TextButton,ICheckable {
    var isChecked:Bool;
    init(_ width : CGFloat, _ height : CGFloat, _ text : String = "defaultText", _ isChecked : Bool = false, _ parent : IElement? = nil, _ id : String? = nil){
        self.isChecked = isChecked;
        super.init(width, height, text, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func mouseUpInside(event: MouseEvent) {
        //Swift.print("CheckTextButton.mouseUpInside()")
        isChecked = !isChecked
        super.mouseUpInside(event)
        self.event!(CheckEvent(CheckEvent.check,isChecked,self))//TODO:Remove the bool from the event. Similar to SelectEvent
    }
    /**
     * Sets the _isChecked variable (Toggles between two states)
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setChecked(isChecked:Bool) {
        self.isChecked = isChecked
        setSkinState(getSkinState())
    }
    func getChecked()->Bool{return isChecked}
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState()
    }
}