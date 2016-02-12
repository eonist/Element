import Foundation

class CheckBoxButton : Button{
    init( width:CGFloat = NaN, _ height:CGFloat = NaN, _ isFocused:Boolean = false, _ isDisabled:Boolean = false, _ text:String = "defaultText", _ isChecked:Bool = false, parent:IElement? = nil, id:String? = nil) {
    _textString = text;
    _isChecked = isChecked;
    super(width,height,isFocused, isDisabled,parent,id,classId);
    }
}
