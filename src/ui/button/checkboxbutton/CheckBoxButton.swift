import Foundation

class CheckBoxButton : Button{
    var checkBox : CheckBox
    var text:Text
    var textString:String
    var isChecked:Bool
    init( width:CGFloat, _ height:CGFloat, _ isFocused:Bool = false, _ isDisabled:Bool = false, _ text:String = "defaultText", _ isChecked:Bool = false, parent:IElement? = nil, id:String? = nil) {
        self.textString = text
        self.isChecked = isChecked
        super.init(width,height,parent,id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
