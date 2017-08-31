import Cocoa
@testable import Utils

extension TextSkin{
    /**
     * Set the text and updates the skin
     * TODO: ⚠️️ Add more advance setText features like start and end etc
     */
    func setText(_ text:String){
        textField.stringValue = text
        hasTextChanged = true
        draw()
    }
    /**
     * Applies properties to textfield
     */
    func applyProperties(_ textField:NSTextField){
        let padding:Padding = StyleMetricParser.padding(self)
        let width:CGFloat = getWidth()//(StyleMetricParser.width(self)  ?? {fatalError("err")}()) + padding.left + padding.right// :TODO: only querry this if the size has changed?
        let height:CGFloat = getHeight() + padding.top + padding.bottom //(StyleMetricParser.height(self)  ?? {fatalError("err")}()) + padding.top + padding.bottom// :TODO: only querry this if the size has changed?
        let size = CGSize(width,height)
//        Swift.print("applyProperties.size: " + "\(size)")
        textField.frame.size = size
        
        super.frame.size = size//quick fix, this is a strange bug
        
        
        TextFieldModifier.applyTextFormat(textField,textFormat)/*applies the textFormat*/
        let temp = TextFormatUtils.attributedStringValue(stringValue:textField.stringValue,textFormat:textFormat)
        textField.attributedStringValue = temp
    }
}
