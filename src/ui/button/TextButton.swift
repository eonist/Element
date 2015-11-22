import Foundation

class TextButton:Button {
    var textString:String;
    init(text:String = "defaultText", _ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        textString = text;
        super.init(width, height, parent, id)
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func resolveSkin():void {
        super.resolveSkin();
        text = addChild(new Text(width,height,_textString,this)) as Text;
        text.mouseChildren = _text.mouseEnabled = _text.buttonMode = false;
    }
}
