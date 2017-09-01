import Foundation
@testable import Utils

/**
 * NOTE: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 * NOTE: isChecked is not priv because setting it manually and then setting style is cheaper than using setSkinState. TreeList uses this scheme
 */
class CheckButton2:Button {
    private var _state:CheckedState = .none
    var state:CheckedState {
        get{return _state}
        set{/*Sets the self.isChecked variable (Toggles between two states)*/
            self._state = newValue
            skinState = {self.skinState}()//refresh skinState
        }
    }
    init(state:CheckedState, size: CGSize, id: String? = nil) {
        super.init(size: size, id: id)
    }
    override func mouseUpInside(_ event:MouseEvent) {
        state = state == .none ? .checked : .none
        super.mouseUpInside(event)
        super.onEvent(CheckEvent2(state:_state, origin:self))
    }
    override var skinState:String {
        get {return _state == .none ? super.skinState : _state.rawValue + " " + super.skinState }
        set {super.skinState = newValue}
    }
    override func getClassType() -> String {
        return "\(CheckButton.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

protocol Checkable2{
    var state:CheckedState {get set}
}
/**
 * Mix state can only be set from outside
 */
enum CheckedState:String{
    case checked = "checked", mix = "mix", none = "none"
}
