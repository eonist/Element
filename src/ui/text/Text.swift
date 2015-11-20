import Cocoa

class Text:Element,IText {
    var initText:String;
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    /**
     * Sets text to the textfield, remember to set textformat after
     * @Note: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
     */
    var text:String{get{return textField.string!} set{(skin as! ITextSkin).text = newValue}}
    var initText:String{get{return initText}}
    init(width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        initText = text
        super.init(width, height,0,0, parent, id)
    }
    /**
     * Returns "Text"
     * @Note This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return String(Text);
    }
}
