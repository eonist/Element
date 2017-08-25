import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ Implement a way to also include the text in being in a checked status
 */
class CheckBoxButton:Button,Checkable,LableKind{//TODO: ⚠️️⚠️️     extend TextButton likeRadioButton does it. it means less code
    private var isChecked:Bool//TODO: ⚠️️ This should be initChecked, and then we should use only checkBox as a state holder
    var textString:String
    lazy var checkBox:CheckBox = createCheckBox()
    lazy var text:Text = createText()
    init(text:String = "defaultText",isChecked:Bool = false,size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.textString = text
        self.isChecked = isChecked
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = checkBox/*Init the UI*/
        _ = text/*Init the UI*/
    }
//    override func onEvent(_ event:Event) {//TODO: You could remove this method, as it doesn't add any functionality
//        super.onEvent(event)/*Forwards the event*/
//    }
    func setChecked(_ isChecked:Bool) {
        checkBox.setChecked(isChecked)
    }
    func getChecked() -> Bool {
        return checkBox.getChecked()
    }
    override var skinState:String {
        get {return isChecked ? SkinStates.checked + " " + super.skinState : super.skinState}
        set {
            super.skinState = newValue
            checkBox.skinState = {checkBox.skinState}()//New, more like refresh, worked 🎉
            text.skinState = {text.skinState}()//New, same as above /*Why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
        }
    }
    func setSize(width:CGFloat, height:CGFloat) {
        super.setSize(width, height)
        checkBox.skinState = {checkBox.skinState}()
        text.skinState = {text.skinState}()
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
    //DEP
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ parent:ElementKind? = nil, _ id:String? = nil) {
        self.textString = text
        self.isChecked = isChecked
        super.init(width,height,parent,id)
    }
}
class CheckBox:CheckButton{}/*CheckBox purly exists to differentiate between types in CSS*/
extension CheckBoxButton{
    func getText()->String{return text.getText()}
    func setTextValue(_ text:String){self.text.setText(text)}
    func createCheckBox()->CheckBox{
        return self.addSubView(CheckBox(13,13,self.isChecked,self))
    }
    func createText() -> Text {
        let text = self.addSubView(Text(self.getWidth(),self.getHeight(),self.textString,self))
        text.isInteractive = false
        return text
    }
}
