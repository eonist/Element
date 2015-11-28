import Cocoa

class CircleGraphic:GraphicDecoratable,IPositionalGraphic,ISizeable {
    var radius:CGFloat?
    var width:CGFloat {get{return radius!}set{fatalError("NOT SUPPORTED")}}
    var height:CGFloat {get{return radius!}set{fatalError("NOT SUPPORTED")}}
    init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {
        //Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(decoratable)
    }
    override func drawFill() {
        //Swift.print("CircleGraphic.drawFill()")
        getGraphic().path = CGPathParser.circle(radius!, getGraphic().x, getGraphic().y)
    }
    override func drawLine() {
        //Swift.print("CircleGraphic.drawLine()")
        graphic.linePath = CGPathParser.circle(radius!, getGraphic().x, getGraphic().y)
    }
}
