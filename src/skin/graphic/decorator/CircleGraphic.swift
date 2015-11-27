import Foundation

class CircleGraphic:BaseGraphic {
    init(_ radius:CGFloat,_ decoratable: IGraphicDecoratable) {
        self.radius = radius
        super.init(decoratable)
    }

    override func drawFill() {
        //CGPathParser.circle(100, x, x)
    }
    override func drawLine() {
        //needs code
        
    }
}
