import Cocoa

class ColorBox:Button/*,IColorInput*/{
    var color:NSColor
    init(width:CGFloat = NaN, height:CGFloat = NaN, color:NSColor = NSColor.magentaColor(), parent:IElement? = nil, id:String = "") {
        self.color = color
        super.init(width,height,parent,id)
        //setColor(color)
    }
    override func mouseDown(event: MouseEvent) {
        super.onEvent(ColorBoxEvent(ColorBoxEvent.change,color))
    }
    func setColorValue(color:NSColor){
        self.color = color
        let style:IStyle = StyleModifier.clone(skin!.style!,skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        var styleProperty = style.getStyleProperty("fill",1) /*edits the style*/
        styleProperty!.value = color.hex
        skin!.setStyle(style)/*updates the skin*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
