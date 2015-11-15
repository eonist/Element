import Foundation

class RectGraphic2:GraphicDecorator{
    var width:Double;
    var height:Double;
    init(_ decoratable: IGraphicDecorator, _ width:Double = 100, _ height:Double = 100) {
        self.width = width;
        self.height = height;
        super.init(decoratable)
    }
    override func drawFill() {
        getGraphic().path = CGPathParser.rect(CGFloat(width), CGFloat(height))
    }
}
