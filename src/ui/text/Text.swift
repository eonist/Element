import Cocoa

class Text:Element,IText {
    var initText:String;//this value is accessed by the TextSkin (It is not meant for external accessing from other classes)
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    var text:String//{get{return textField.string!} set{fatalError("NOT SUPPORTED YET")}}
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
}
