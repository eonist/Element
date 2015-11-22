import Cocoa

class Text:Element,IText {
    var initText:String;
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    var text:String{get{return textField.string!} set{fatalError("NOT SUPPORTED YET")}}
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        initText = text
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * Sets text to the textfield, remember to set textformat after
     * @Note: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
     * NOTE: Apperently setText() is occupied by obj-c, use var text {get set} in the future
     */
    func applyText(text:String){
        (skin as! TextSkin).setText(text)
    }
    /**
     * Returns the textField text and 
     */
    func getText()->String{
        return getTextField().string!;
    }
    func getTextField()->NSText{
        return (skin as! ITextSkin).textField;
    }
    /**
     * Returns "Text"
     * @Note This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return String(Text);
    }
}
