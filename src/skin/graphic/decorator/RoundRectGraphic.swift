import Foundation

class RoundRectGraphic:GraphicDecoratable{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    override func drawFill() {
        //Swift.print("RoundRectGraphic2.drawFill() ")
        let w:Double = (decoratable as! RectGraphic2).width
        //Swift.print("w: " + "\(w)")
        let h:Double = (decoratable as! RectGraphic2).height
        //Swift.print("h: " + "\(h)")
        //Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().path = CGPathParser.roundRect(0,0,CGFloat(w), CGFloat(h),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
    }
}