import Foundation
@testable import Utils

/**
 * NOTE: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 * NOTE: isChecked is not priv because setting it manually and then setting style is cheaper than using setSkinState. TreeList uses this scheme
 */
class CheckButton2:Button {
    var state:CheckedState = .none{
        didSet{/*Sets the self.isChecked variable (Toggles between two states)*/
            skinState = {self.skinState}()//refresh skinState
        }
    }
    init(state:CheckedState, size: CGSize, id: String? = nil) {
        self.state = state
        super.init(size: size, id: id)
    }
    override func mouseUpInside(_ event:MouseEvent) {
        state = state == .none ? .checked : .none
        super.mouseUpInside(event)
        super.onEvent(CheckEvent2(state:state, origin:self))
    }
    override var skinState:String {
        get {return state == .none ? super.skinState : state.rawValue + " " + super.skinState }
        set {super.skinState = newValue}
    }
    override func getClassType() -> String {
        return "\(CheckButton.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

protocol Checkable2{
    var state:CheckedState {get set}//rename to checkedState or checkState
}
/**
 * Mix state can only be set from outside
 */
enum CheckedState:String{
    case checked = "checked", mix = "mix", none = "none"
}
