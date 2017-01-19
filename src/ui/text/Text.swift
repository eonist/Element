import Cocoa
@testable import Utils

class Text:Element,IText {
    var initText:String;//this value is accessed by the TextSkin (It is not meant for external accessing from other classes)
    var textField:TextField{get{return (skin as! ITextSkin).textField}}
    //var text:String{get{return textField.string!} set{fatalError("NOT SUPPORTED YET")}}
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("Text.init()")
        initText = text
        super.init(width, height, parent, id)
    }
    /**
     * Sets text to the textfield, remember to set textformat after
     * NOTE: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
     * NOTE: Apperently setText() is occupied by obj-c, use var text {get set} in the future
     */
    func setText(_ text:String){//<--- rename to setText, figure out away to either rename the text or rename setText, like setTheText or alike, setTextValue
        (skin as! TextSkin).setText(text)
    }
    /**
     * Returns the textField text and 
     */
    func getText()->String{
        return getTextField().stringValue
    }
    func getTextField()->TextField{
        return (skin as! ITextSkin).textField
    }
    /**
     * Returns "Text"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return "\(Text.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
