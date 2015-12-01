import Foundation
/**
 * The responsibility of this class is to provide access to the position of the SizeableGraphic
 */
class SizeableDecorator:PositionalDecorator,ISizeable {
    var size:CGSize{
        get{
            if(decoratable is SizeableGraphic){return (decoratable as! SizeableGraphic).size}
            else{fatalError("Must subclass SizeableGraphic")}
        }
        set{
            if(decoratable is SizeableGraphic){(decoratable as! SizeableGraphic).size = newValue}
            else{fatalError("Must subclass SizeableGraphic")}
        }
    }
    func getSize() -> CGSize {
        return size
    }
}
