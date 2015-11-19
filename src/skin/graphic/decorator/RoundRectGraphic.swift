import Foundation

class RoundRectGraphic:GraphicDecoratable{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    override func drawFill() {
        let x:CGFloat = graphic.lineOffsetType!.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        let y:CGFloat = graphic.lineOffsetType!.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        //Swift.print("RoundRectGraphic2.drawFill() ")
        let w:CGFloat = getGraphic().width
        //Swift.print("w: " + "\(w)")
        let h:CGFloat = getGraphic().height
        //Swift.print("h: " + "\(h)")
        //Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().path = CGPathParser.roundRect(x,y,w, h,CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
    }
}