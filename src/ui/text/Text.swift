import Cocoa

class Text:Element,IText {
    /**
    * Sets text to the textfield, remember to set textformat after
    * @Note: to access htmlText: ITextSkin2(_skin).textField.htmlText = htmlText;
    */
    var textField:NSText{get{return (skin as! ITextSkin).textField}}
    var text:String{get{return textField.string}set{ITextSkin(skin).text = newValue}}

}
