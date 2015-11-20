import Cocoa

class Text:Element,IText {
    private var initText:String;
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    /**
     * Sets text to the textfield, remember to set textformat after
     * @Note: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
     */
    var text:String{get{return textField.string!} set{(skin as! ITextSkin).text = newValue}}
    var initText:String{get{return initText}}
    init(width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        self.initText = text
    }
}
