
import Cocoa
/**
 * NOTE: the reason this class extends SizeableGraphic and not SizeableDecorator is because SizeableDecorator doesnt hold any size, it merly passes the size that the instance it decorates holds. Same goes for PositionalDecorator
 */
class EmptyGraphic:SizeableGraphic{

    override func drawFill() {
        //Swift.print("RectGraphic.drawFill()")
        //graphic.fillShape.path = CGRect(0,0,width,height).path/*Draws in the local coordinate space of the shape*/
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!.thickness, graphic.lineOffsetType) : CGRect(x,y,1.0,1.0)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        //Swift.print("graphic.fillShape.frame: " + "\(graphic.fillShape.frame)")
    }

    override func drawLine(){
        
        
    }
}