
import Cocoa
/**
 * NOTE: the reason this class extends SizeableGraphic and not SizeableDecorator is because SizeableDecorator doesnt hold any size, it merly passes the size that the instance it decorates holds. Same goes for PositionalDecorator
 */
class EmptyGraphic:SizeableGraphic{

    override func drawFill() {
       
    }

    override func drawLine(){
        
        
    }
}