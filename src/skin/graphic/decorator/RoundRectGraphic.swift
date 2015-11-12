import Cocoa

class RoundRectGraphic:Decoratable,IRoundRectGraphic{
    var fillet:Fillet;
    init(_ decoratable:IDecoratable, _ fillet:Fillet? = nil){
        self.fillet = fillet ?? Fillet();
        super.init(decoratable);
        fill();
        //line();
    }
    override func fill() {
        Swift.print("RoundRectGraphic.fill() ")
        beginFill();
        drawFill();
    }
    override func line() {
        
    }
    /**
     * Draws the fill
     */
    override func drawFill(){
        Swift.print("RoundRectGraphic.drawFill() ")
        let w:Double = 300//(decoratable as! RectGraphic).width
        Swift.print("w: " + "\(w)")
        let h:Double = (decoratable as! RectGraphic).height
        Swift.print("h: " + "\(h)")
        Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().path = CGPathParser.roundRect(0,0,CGFloat(w), CGFloat(h),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
        GraphicModifier.stylize(getGraphic().path,getGraphic().graphics)//realize style on the graphic
    }
}