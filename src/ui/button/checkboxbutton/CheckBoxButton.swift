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
    override func resolveSkin():void {
        super.resolveSkin();
        _checkBox = addChild(new CheckBox(height,height,false,false,_isChecked,this)) as CheckBox;
        _text = addChild(new Text(width,height,_textString,this)) as Text;
        _text.mouseChildren = _text.mouseEnabled = _text.buttonMode = false;
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
