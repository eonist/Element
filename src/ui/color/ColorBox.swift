import Foundation

class ColorBox:Button{
    var color:CGFloat
    init(width:CGFloat = NaN, height:CGFloat = NaN, color:CGFloat = 16711935/*<--Color.MAGENTA*/, parent:IElement? = nil, id:String = "") {
        self.color = color
        super.init(width,height,parent,id)
        //setColor(color)
    }
    override func mouseDown(event: MouseEvent) {
        super.onEvent(ColorBoxEvent(ColorBoxEvent.change,color))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
