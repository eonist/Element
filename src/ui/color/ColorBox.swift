import Cocoa

class ColorBox:Button/*,IColorInput*/{
    var color:CGFloat
    init(width:CGFloat = NaN, height:CGFloat = NaN, color:CGFloat = 16711935/*<--Color.MAGENTA*/, parent:IElement? = nil, id:String = "") {
        self.color = color
        super.init(width,height,parent,id)
        //setColor(color)
    }
    override func mouseDown(event: MouseEvent) {
        super.onEvent(ColorBoxEvent(ColorBoxEvent.change,color))
    }
    func setColor(color:NSColor){
        self.color = color
        var style:IStyle = StyleModifier.clone(skin.style,skin.style.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        style.getStyleProperty("fill",1).value = color/*edits the style*/
        skin.setStyle(style)/*updates the skin*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
