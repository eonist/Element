import Foundation

class RoundRectGraphic2:GraphicDecorator{//adds round-rectangular path
    override func drawFill() {
        let fillet:Fillet = Fillet(20)
        getGraphic().path = CGPathParser.roundRect(0,0,CGFloat(200), CGFloat(200),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
    }
}