import Foundation
@testable import Utils
/**
 * TODO: Implement a way to also include the text in being in a checked status
 */
class CheckBoxButton:Button,ICheckable,LableKind{
    private var isChecked:Bool
    var textString:String
    var checkBox:CheckBox?
    var text:Text?
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text
        self.isChecked = isChecked
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        checkBox = addSubView(CheckBox(13,13,isChecked,self))
        text = addSubView(Text(width,height,textString,self)) 
        text!.isInteractive = false
    }
    override func onEvent(_ event:Event) {//TODO: You could remove this method, as it doesnt add any functionality
        super.onEvent(event)/*Forwards the event*/
    }
    func setChecked(_ isChecked:Bool) {
        checkBox!.setChecked(isChecked)
    }
    func getChecked() -> Bool {
        return checkBox != nil ? checkBox!.getChecked() : self.isChecked/*<--Temp fix*/
    }
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState()
    }
    override func setSkinState(_ skinState:String) {
        super.setSkinState(skinState)
        //checkBox!.setSkinState(checkBox!.getSkinState())//new, more like refresh, worked 🎉
        //text!.setSkinState(text!.getSkinState())//new, same as above /*Why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
    }
    func setSize(width:CGFloat, height:CGFloat) {
        super.setSize(width, height)
        checkBox!.setSkinState(checkBox!.skin!.state)
        text!.setSkinState(checkBox!.skin!.state)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class CheckBox:CheckButton{}/*CheckBox purly exists to differentiate between types in CSS*/
extension CheckBoxButton{
    func getText()->String{return text!.getText()}
    func setTextValue(_ text:String){self.text!.setText(text)}
}
