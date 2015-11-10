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
        beginFill();
        drawFill();
    }
    override func line() {
        
    }
    /**
     * Draws the fill
     */
    override func drawFill(){
        let w:Double = (decoratable as! RectGraphic).width
        let h:Double = (decoratable as! RectGraphic).height
        getGraphic().path = CGPathParser.roundRect(0,0,CGFloat(w), CGFloat(h),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
        GraphicModifier.stylize(getGraphic().path,getGraphic().graphics)//realize style on the graphic
    }
}