import Cocoa

class Text:Element,IText {
    var initText:String;
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    /**
     * Returns the textField text and Sets text to the textfield, remember to set textformat after
     * @Note: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
     */
    var text:String{get{return textField.string!} set{(skin as! TextSkin).text = newValue}}
    init(width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        initText = text
        super.init(width, height,0,0, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * Returns "Text"
     * @Note This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return String(Text);
    }
}
