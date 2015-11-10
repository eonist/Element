import Foundation

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
      
        
        //_fillet.topLeft, _fillet.topRight, _fillet.bottomLeft, _fillet.bottomRight
        //x, y, graphic.width, graphic.height, _fillet.topLeft, _fillet.topRight, _fillet.bottomLeft, _fillet.bottomRight
        
        path = CGPathParser.roundRect(0,0,CGFloat(width), CGFloat(height))//Shapes
        GraphicModifier.stylize(path,graphics)//realize style on the graphic
        
        
    }
}