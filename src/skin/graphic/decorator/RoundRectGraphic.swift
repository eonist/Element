import Foundation

class RoundRectGraphic:Decoratable,IRoundRectGraphic{
    var fillet:Fillet;
    init(_ decoratable:IDecoratable, _ fillet:Fillet? = nil){
        self.fillet = fillet ?? Fillet();
        super.init(decoratable);
        fill();
        line();
    }
    override func fill() {
        beginFill();
        drawFill();
    }
    override func line() {
        applyLineStyle(graphic.graphics, graphic.lineStyle);
        drawLine();
    }
}