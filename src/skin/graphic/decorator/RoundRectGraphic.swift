import Foundation

class RoundRectGraphic:Decoratable3,IDecoratable{
    var fillet:Fillet;
    init(decoratable:IDecoratable, fillet:Fillet? = nil){
        self.fillet = fillet ?? Fillet();
        super(decoratable);
    }
}
