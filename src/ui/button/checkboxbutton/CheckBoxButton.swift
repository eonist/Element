import Foundation

class CheckBoxButton : Button{
    var checkBox : CheckBox?
    var text:Text?
    var textString:String
    var isChecked:Bool
    init( width:CGFloat, _ height:CGFloat, _ isFocused:Bool = false, _ isDisabled:Bool = false, _ text:String = "defaultText", _ isChecked:Bool = false, parent:IElement? = nil, id:String? = nil) {
        self.textString = text
        self.isChecked = isChecked
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        checkBox = addSubView(CheckBox(height,height,isChecked,self)) as? CheckBox
        text = addSubView(Text(width,height,textString,self)) as? Text
        text!.isInteractive = false
    }
    func setChecked(isChecked:Bool) {
        _checkBox.setChecked(isChecked);
    }
    func getSkinState() -> String {
        return _isChecked ? SkinStates.CHECKED + " " + super.getSkinState() : super.getSkinState();
    }
    func setSize(width : CGFloat, height : CGFloat) {
        super.setSize(width, height);
        _checkBox.setSkinState(_checkBox.skin.state);
        _text.setSkinState(_checkBox.skin.state);
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
