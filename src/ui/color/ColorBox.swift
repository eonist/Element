import Cocoa

class ColorBox:Button,IColorInput{
    var color:NSColor
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ color:NSColor = NSColor.magentaColor(), _ parent:IElement? = nil, _ id:String = "") {
        self.color = color
        super.init(width,height,parent,id)
        setColorValue(color)
    }
    override func mouseDown(event: MouseEvent) {
        super.onEvent(ColorBoxEvent(ColorBoxEvent.change,color))
    }
    func setColorValue(color:NSColor){
        self.color = color
        let style:IStyle = StyleModifier.clone(skin!.style!,skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        StyleParser.describe(style)
        var styleProperty = style.getStyleProperty("fill",1) /*edits the style*/
        Swift.print("styleProperty: " + "\(styleProperty)")
        Swift.print("color.hex: " + "\(color.hex)")
        styleProperty!.value = color.hex
        skin!.setStyle(style)/*updates the skin*/
    }
    /**
     * Returns "ColorBox"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType() -> String {
        return String(ColorBox);
    }
    override func setSkinState(state:String){
        /*temp fix so that the color doesnt change on button interaction*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
