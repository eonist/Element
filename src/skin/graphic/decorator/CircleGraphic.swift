import Cocoa

class CircleGraphic:GraphicDecoratable {
    var x:CGFloat = 0
    var y:CGFloat = 0
    var radius:CGFloat?
    init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {
        Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(decoratable)
    }
    override func drawFill() {
        Swift.print("CircleGraphic.drawFill()")
        getGraphic().path = CGPathParser.circle(radius!, x, y)
    }
    override func drawLine() {
        Swift.print("CircleGraphic.drawLine()")
        graphic.linePath = CGPathParser.circle(radius!, x, y)
    }
    /**
     * TODO: remove the x and y values from this class, some graphics may not have a natural x and y pos like LineGraphic or PathGraphic
     */
    override func setPosition(position:CGPoint){
        x = position.x
        y = position.y
        //path = CGPathModifier.translate(&path,position.x,position.y)//Transformations
        //linePath = CGPathModifier.translate(&linePath,position.x,position.y)//Transformations
    }
}
