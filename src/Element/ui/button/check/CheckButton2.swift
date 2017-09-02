import Foundation
@testable import Utils

/**
 * NOTE: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 * NOTE: isChecked is not priv because setting it manually and then setting style is cheaper than using setSkinState. TreeList uses this scheme
 */
class CheckButton2:Button {
    var checkedState:CheckedState = .none{
        didSet{/*Sets the self.isChecked variable (Toggles between two states)*/
            skinState = {self.skinState}()//refresh skinState
        }
    }
    init(state:CheckedState, size: CGSize, id: String? = nil) {
        self.checkedState = state
        super.init(size: size, id: id)
    }
    override func mouseUpInside(_ event:MouseEvent) {
        checkedState = checkedState == .none ? .checked : .none
        super.mouseUpInside(event)
        super.onEvent(CheckEvent2(state:checkedState, origin:self))
    }
    override var skinState:String {
        get {return checkedState == .none ? super.skinState : checkedState.rawValue + " " + super.skinState }
        set {super.skinState = newValue}
    }
    override func getClassType() -> String {
        return "\(CheckButton.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

protocol Checkable2{
    var checkedState:CheckedState {get set}//rename to checkedState or checkState
}
/**
 * Mix state can only be set from outside
 */
enum CheckedState:String{
    case checked = "checked", mix = "mix", none = "none"
}
