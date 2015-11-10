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
    override func drawFill():void {
        var x:Number = graphic.lineOffsetType.left == OffsetType.OUTSIDE ? graphic.lineStyle.thickness : 0;
        var y:Number = graphic.lineOffsetType.top == OffsetType.OUTSIDE ? graphic.lineStyle.thickness : 0;
        graphic.fillShape.graphics.drawRoundRectComplex(x, y, graphic.width, graphic.height, _fillet.topLeft, _fillet.topRight, _fillet.bottomLeft, _fillet.bottomRight);
    }
}