import Foundation
/**
 * TODO: Shorten the bellow code with if shorthand
 */
class SizeableDecorator:PositionalDecorator,ISizeable {
    var size:CGSize{
        get{
            if(decoratable is SizeableGraphic){
                return (decoratable as! SizeableGraphic).size
            }else{
                fatalError("Must subclass SizeableGraphic")
            }
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
