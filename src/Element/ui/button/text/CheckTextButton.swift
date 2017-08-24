import Cocoa
@testable import Utils

class CheckTextButton:TextButton,Checkable {
    var isChecked:Bool
    init(_ width : CGFloat, _ height : CGFloat, _ text : String = "defaultText", _ isChecked : Bool = false, _ parent : ElementKind? = nil, _ id : String? = nil){
        self.isChecked = isChecked;
        super.init(width, height, text, parent, id)
    }
    override func mouseUpInside(_ event:MouseEvent) {
        isChecked = !isChecked
        super.mouseUpInside(event)
        self.event!(CheckEvent(CheckEvent.check,isChecked,self))//TODO:Remove the bool from the event. Similar to SelectEvent
    }
    /**
     * Sets the isChecked variable (Toggles between two states)
     * NOTE: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setChecked(_ isChecked:Bool) {
        self.isChecked = isChecked
        skinState = {self.skinState}()
    }
    func getChecked()->Bool{return isChecked}
    override var skinState:String {
        get {return isChecked ? SkinStates.checked + " " + super.skinState : super.skinState}
        set {super.skinState = newValue}
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    required init(from decoder: Decoder) throws {fatalError("init(from:) has not been implemented")}
}
