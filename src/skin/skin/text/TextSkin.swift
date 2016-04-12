import Cocoa
/**
 * TODO: For the sake of optiomization, TextSkin should not extend Skin, but rather extend NSText. Less views means better speed
 * //TODO:probably disable ineteractivity when using TextSkin ? 
 */
class TextSkin:Skin,ITextSkin{
    var textField:TextField;
    //the bellow variable is a little more complex in the legacy code
    override var width:CGFloat? {get{return textField.frame.width} set{textField.frame.width = newValue!}}// :TODO: make a similar funciton for getHeight, based on needed space for the height of the textfield
    private var hasTextChanged:Bool = true;/*<-Why is is this true by default?*/
    //func setText(text:String)
    init(_ style:IStyle, _ text:String, _ state:String = SkinStates.none, _ element:IElement? = nil){
        //Swift.print("TextSkin.init()")
        textField = TextField(frame: NSRect())
        //textField.sizeToFit()
        textField.stringValue = text
        super.init(style, state, element)
        addSubview(textField)
        applyProperties(textField)
        SkinModifier.float(self)
        SkinModifier.align(self, textField)
        textField.hidden = SkinParser.display(self) == CSSConstants.none
    }
    override func draw() {
        if (hasStyleChanged || hasSizeChanged || hasStateChanged || hasTextChanged) {
            SkinModifier.float(self)
            if(hasSizeChanged) {
                let padding:Padding = StylePropertyParser.padding(self);
                TextFieldModifier.size(textField, width! + padding.left + padding.right, height! + padding.top + padding.bottom);
            }
            if(hasStateChanged || hasStyleChanged || hasTextChanged) {applyProperties(textField)}
            if(hasTextChanged) {hasTextChanged = false}
            SkinModifier.align(self, textField)
            
        }
        super.draw()
    }
    func applyProperties(textField:TextField){
        
        //Continue here, bug here cant get width
        
        let padding:Padding = StylePropertyParser.padding(self);
        let width:CGFloat = (StylePropertyParser.width(self) ?? super.width!) + padding.left + padding.right;// :TODO: only querry this if the size has changed?
        //Swift.print("TextSkin.applyProperties() width: " + "\(width)")
        let height:CGFloat = (StylePropertyParser.height(self) ?? super.height!) + padding.top + padding.bottom;// :TODO: only querry this if the size has changed?
        //Swift.print("TextSkin.applyProperties() height: " + "\(height)")
        textField.frame.width = width/*SkinParser.width(this);*/
        textField.frame.height = height/*SkinParser.height(this);*/
        super.frame.width = width//quick fix
        super.frame.height = height//quick fix
        let textFormat:TextFormat = StylePropertyParser.textFormat(self)
        //Swift.print("TextSkin.applyProperties() textFormat.color: " + String(textFormat.color))
        TextFieldModifier.applyTextFormat(textField,textFormat)
        textField.stringValue = textField.stringValue + " "
    }
    /**
     * Set the text and updates the skin
     * // :TODO: add more advance setText features like start and end etc
     */
    func setText(text:String){
        textField.stringValue = text
        hasTextChanged = true
        //draw();//<---this must be uncommented, it was commented just for a test to be completed. Very imp. Debug the problem with it. its probaly simple
    }
    
    /**
     * // :TODO: make a similar funciton for getHeight, based on needed space for the height of the textfield
     */
    override func getWidth() -> CGFloat {
        //Swift.print("TextSkin.getWidth()")
        if((StylePropertyParser.value(self, TextFormatConstants.wordWrap) == nil)){/*if the wordWrap is false the the width of the skin is equal to the width of the textfield (based on needed space for the text)*/
            let padding:Padding = StylePropertyParser.padding(self);
            return textField.frame.width + padding.left + padding.right;
        }else {return super.getWidth()}
    }
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
