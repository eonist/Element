import Foundation

class PathGraphic {
    override func drawFill() {
        //Swift.print("EllipseGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!.thickness, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.ellipse(CGRect(0,0,width,height))
    }
    override func drawLine() {
        
    }
}
