import Foundation

class RoundRectGraphic2:GraphicDecoratable{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    override func drawFill() {
        //let fillet:Fillet = Fillet(20)
        getGraphic().path = CGPathParser.roundRect(0,0,CGFloat(200), CGFloat(200),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
    }
}