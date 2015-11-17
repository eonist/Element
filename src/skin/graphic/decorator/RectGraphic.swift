import Foundation

class RectGraphic:GraphicDecoratable{
    /**
     *
     */
    override func drawFill() {
        getGraphic().path = CGPathParser.rect(CGFloat(getGraphic().width), CGFloat(getGraphic().height))
    }
    /**
     *
     */
    func drawLine(){
        if(getGraphic().lineStyle != nil){
            let rect:CGRect = RectGraphicUtils.offsetRect(CGRect(0, 0, getGraphic().width, getGraphic().height), getGraphic().lineStyle!, getGraphic().lineOffsetType!);
            //drawLine
            let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0, getGraphic().width,getGraphic().height), getGraphic().lineStyle!, getGraphic().lineOffsetType!);
            //draw the mask line
        }
    }
}
