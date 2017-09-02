import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Impliment IDisableable also and extend DisableTextButton
 * make the old init method to support legacy stuff.
 */
class CheckBoxButton2:TextButton,Checkable2{
    lazy var checkBox:CheckBox2 = createCheckBox()
    private let initState:CheckedState
    var state:CheckedState {/*we  only checkBox as a state holder*/
        get{return checkBox.state}
        set{/*Sets the self.isChecked variable (Toggles between two states)*/
            checkBox.state = newValue
        }
    }
    init(text:String = "defaultText", checkedState:CheckedState = .none,size:CGSize = CGSize(0,0),id:String? = nil){
        self.initState = checkedState
        super.init(text:text, size: size, id: id)
        //text.isInteractive = false
    }
    /**
     * NOTE: When added to stage and if RadioBullet dispatches selct event it will bubble up and through this class (so no need for extra eventlistners and dispatchers in this class)
     * NOTE: The radioBullet has an id of "radioBullet" (this may be usefull if you extend CheckBoxButton and that subclass has children that are of type Button and you want to identify this button and noth the others)
     */
    override func resolveSkin() {
        super.resolveSkin()
        _ = checkBox/*Init the UI*/
    }
    func setSize(width:CGFloat, height:CGFloat) {
        super.setSize(width, height)
        checkBox.skinState = {checkBox.skinState}()
        text.skinState = {text.skinState}()
    }
    override func getClassType() -> String {
        return "\(CheckBoxButton.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

class CheckBox2:CheckButton2{
    override func getClassType() -> String {
        return "\(CheckBox.self)"
    }
}/*CheckBox purly exists to differentiate between types in CSS*/
extension CheckBoxButton2{
//    func getText()->String{return text.getText()}
//    func setTextValue(_ text:String){self.text.setText(text)}
    func createCheckBox()->CheckBox2{
        return self.addSubView(CheckBox2.init(state: self.initState, size: CGSize(13,13)))
    }
}
