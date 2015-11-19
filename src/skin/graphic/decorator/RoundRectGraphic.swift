import Foundation

class RoundRectGraphic:GraphicDecoratable{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    override func drawFill() {
        var x:Number = graphic.lineOffsetType.left == OffsetType.OUTSIDE ? graphic.lineStyle.thickness : 0;
        var y:Number = graphic.lineOffsetType.top == OffsetType.OUTSIDE ? graphic.lineStyle.thickness : 0;
        //Swift.print("RoundRectGraphic2.drawFill() ")
        let w:CGFloat = getGraphic().width
        //Swift.print("w: " + "\(w)")
        let h:CGFloat = getGraphic().height
        //Swift.print("h: " + "\(h)")
        //Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().path = CGPathParser.roundRect(0,0,w, h,CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
    }
}