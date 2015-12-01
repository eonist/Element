import Foundation
/**
 * TODO: Shorten the bellow code with if shorthand
 */
class SizeableDecorator:PositionalDecorator,ISizeable {
    var size:CGSize{
        get{
           return decoratable is SizeableGraphic ?  (decoratable as! SizeableGraphic).size : fatalError("Must subclass SizeableGraphic")
            
        }
        set{
            if(decoratable is SizeableGraphic){
                (decoratable as! SizeableGraphic).size = newValue
            }else{
                fatalError("Must subclass SizeableGraphic")
            }
        }
    }
    func getSize() -> CGSize {
        return size
    }
}
