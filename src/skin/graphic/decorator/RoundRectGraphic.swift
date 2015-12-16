import Foundation
/*
* TODO: the mask doesnt have an exact fitting fillet (figure out how to solve this)
* TODO: impliment elliptical round corners corner-radius:50/25; creates an elliptical roundcornered rect
* NOTE we might need to create a method named drawAdvanceRoundRect, which would draw a round rect with individual corners that also could have 2 radiuses ech so you would have elliptical corners,
* google for Drawing Circles with Rational Quadratic Bezier Curves.pdf or use a value named kappa which is basically kappa = 4 * (sqrt(2) - 1) / 3
* NOTE: CGRect has a roundRect method with eliptical corners. You have this code in your research folder
*/
class RoundRectGraphic:SizeableDecorator{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        let x:CGFloat = graphic.lineOffsetType.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        let y:CGFloat = graphic.lineOffsetType.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        //Swift.print("RoundRectGraphic2.drawFill() ")
        let w:CGFloat = self.width
        //Swift.print("w: " + "\(w)")
        let h:CGFloat = self.height
        //Swift.print("h: " + "\(h)")
        //Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().fillShape.path = CGPathParser.roundRect(x,y,w,h,fillet.topLeft, fillet.topRight, fillet.bottomLeft, fillet.bottomRight)//Shapes
    }
    /**
     *
     */
    override func drawLine(){
        //Swift.print("RoundRectGraphic.drawLine() " + String(graphic.lineStyle != nil))
        if(graphic.lineStyle != nil){/*updates only if lineStyle and lineStyle.color are valid*/// :TODO: this check could possibly be redundant
            let lineOffsetType:OffsetType = graphic.lineOffsetType;
            let rect:CGRect = RectGraphicUtils.offsetRect(CGRect(0, 0, /*decoratable.*/getSize().width, /*decoratable.*/getSize().height), graphic.lineStyle!, lineOffsetType);
            //Swift.print(rect)
            let fillet:Fillet = FilletParser.config(self.fillet, lineOffsetType, graphic.lineStyle!);
            graphic.lineShape.path = CGPathParser.roundRect(rect.x,rect.y,rect.width,rect.height,fillet.topLeft, fillet.topRight, fillet.bottomLeft, fillet.bottomRight)
            /*mask*/
            //let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0,graphic.width,graphic.height), graphic.lineStyle!, lineOffsetType);
        }
    }
}