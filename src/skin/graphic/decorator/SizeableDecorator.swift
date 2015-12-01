import Foundation
/**
 * The responsibility of this class is to provide access to the position of the SizeableGraphic
 */
class SizeableDecorator:PositionalDecorator,ISizeable {
    var size:CGSize{
        get{
            if(decoratable is ISizeable){return (decoratable as! ISizeable).size}
            else{fatalError("Must subclass SizeableGraphic")}
        }
        set{
            fatalError("You cant set size only get")
            //if(decoratable is ISizeable){(decoratable as! SizeableGraphic).size = newValue}
            //else{fatalError("Must subclass SizeableGraphic")}
        }
    }
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getSize() -> CGSize {
        return size
    }
}
