import Foundation

class RectGraphic2:GraphicDecoratable{
    var width:Double;
    var height:Double;
    init(_ decoratable: IGraphicDecoratable, _ width:Double = 100, _ height:Double = 100) {
        self.width = width;
        self.height = height;
        super.init(decoratable)
    }
    override func drawFill() {
        getGraphic().path = CGPathParser.rect(CGFloat(width), CGFloat(height))
    }
    func setSize(width:Double,height:Double) {
        self.width = width;
        self.height = height;
    }
}
