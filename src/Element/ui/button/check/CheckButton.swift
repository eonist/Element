import Foundation
@testable import Utils
/**
 * NOTE: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 * NOTE: isChecked is not priv because setting it manually and then setting style is cheaper than using setSkinState. TreeList uses this scheme
 */
class CheckButton:Button,Checkable{
    var isChecked:Bool
    init(isChecked:Bool = false,size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.isChecked = isChecked
        super.init(size: size, id: id)
    }
    override func mouseUpInside(_ event:MouseEvent) {
        isChecked = !isChecked
        super.mouseUpInside(event)
        super.onEvent(CheckEvent(CheckEvent.check, isChecked, self))
    }
    /**
     * Sets the self.isChecked variable (Toggles between two states)
     */
    func setChecked(_ isChecked:Bool) {
        self.isChecked = isChecked
        skinState = {self.skinState}()
    }
    func getChecked() -> Bool {
       return isChecked
    }
    override var skinState:String {
        get {return isChecked ? SkinStates.checked + " " + super.skinState : super.skinState}
        set {super.skinState = newValue}
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //
    init(_ width:CGFloat, _ height:CGFloat, _ isChecked:Bool = false, _ parent:ElementKind? = nil, _ id:String? = nil){
        self.isChecked = isChecked
        super.init(size:CGSize(width,height),id:id)
    }
}
