import Foundation

class RectGraphic2:GraphicDecorator{
    override func drawFill() {
        getGraphic().path = CGPathParser.rect(CGFloat(100), CGFloat(100))//Shapes
    }
}
