import Cocoa

/**
 * NOTE: Dont create a circle class, ellipse will do the same as a circle
 * //TODO: possibly add a diameter var
 */

class EllipseGraphic:SizeableGraphic{
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func drawFill() {
        Swift.print("EllipseGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.ellipse(CGRect(0,0,width,height))
    }
    override func drawLine() {
        Swift.print("EllipseGraphic.drawLine()")
        let lineOffsetRect = RectGraphicUtils.lineOffsetRect(CGRect(x,y,width,height), graphic.lineStyle!, graphic.lineOffsetType)
        graphic.lineShape.frame = lineOffsetRect.lineFrameRect
        Swift.print("lineOffsetRect.lineFrameRect: " + "\(lineOffsetRect.lineFrameRect)")
        graphic.lineShape.path = CGPathParser.ellipse(lineOffsetRect.lineRect)
        Swift.print("lineOffsetRect.lineRect: " + "\(lineOffsetRect.lineRect)")
    }
}
//extension EllipseGraphic{
    //use sizableGraphic extension instead
//}