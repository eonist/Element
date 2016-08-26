import Foundation
/**
 * NOTE: the path compile method is the important part in this class
 * NOTE: You need to re-compile the cgPath manually if you want any update to the path to also reflect the cgPath
 */
class PathGraphic:SizeableDecorator{
    var path:IPath
    lazy var cgPath:CGMutablePathRef = CGPathUtils.compile(CGPathCreateMutable(), self.path)/*this is lazy because both drawFill and drawLine uses it, its risky but convenient*/
    lazy var fillBoundingBox:CGRect = CGPathGetPathBoundingBox(self.cgPath)/*this is lazy because both drawFill and drawLine uses it, its risky but convenient*/
    init(_ path:IPath, _ decoratable: IGraphicDecoratable = BaseGraphic(nil,LineStyle())) {
        //Swift.print("PathGraphic.init()")
        self.path = path
        super.init(decoratable)
    }
    override func drawFill() {
        //Swift.print("PathGraphic.drawFill()")
        fillBoundingBox = CGPathGetPathBoundingBox(cgPath)/*there is also CGPathGetPathBoundingBox, CGPathGetBoundingBox, which works a bit different, the difference is probably just support for cruves etc*/
        //Swift.print("fillPathBoundingBox: " + "\(fillBoundingBox)")
        graphic.fillShape.frame = fillBoundingBox/*We need to set frame because this is the lowest level graphic and they must have a frame to be visible*/
        let offset = CGPoint(-fillBoundingBox.x,-fillBoundingBox.y)/*we get the amount of offset need to set the path in (0,0) inside the frame*/
        var offsetPath = cgPath.copy()/*we clone the path so that the original isnt modified*/
        graphic.fillShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)/*we translate the path so that its in (0,0) space in the frame, we position the frame not the path so that the drawing is as optimized as can be*/
    }
    override func drawLine() {
        //Swift.print("PathGraphic.drawLine()")
        var boundingBox:CGRect = CGPathParser.boundingBox(cgPath, graphic.lineStyle!)/*regardless if the line is inside outside or centered, this will still work, as the path is already exapnded correctly*/
        Swift.print("boundingBox: " + "\(boundingBox)")
        let tempBoundingBox:CGRect = CGPathGetPathBoundingBox(cgPath)
        Swift.print("tempBoundingBox: " + "\(tempBoundingBox)")
        //boundingBox += fillBoundingBox.topLeft
        graphic.lineShape.frame = boundingBox/*We need to set frame because this is the lowest level graphic and they must have a frame to be visible*/
        let offset = CGPoint(-boundingBox.x,-boundingBox.y)/*we get the amount of offset need to set the path in (0,0) inside the frame*/
        Swift.print("offset: " + "\(offset)")
        var offsetPath = cgPath.copy()/*we clone the path so that the original isnt modified*/
        graphic.lineShape.path = CGPathModifier.translate(&offsetPath, offset.x, offset.y)/*we translate the path so that its in (0,0) space in the frame, we position the frame not the path so that the drawing is as optimized as can be*/
    }
}
extension PathGraphic{
    convenience init(_ path:IPath, _ fillStyle:IFillStyle?, _ lineStyle:ILineStyle?) {
        //Swift.print("PathGraphic.init() fillStyle, lineStyle")
        let graphic:IGraphicDecoratable = fillStyle is IGradientFillStyle || lineStyle is IGradientLineStyle ? GradientGraphic(BaseGraphic(fillStyle,lineStyle)) : BaseGraphic(fillStyle,lineStyle)
        //Swift.print("graphic: " + "\(graphic)")
        self.init(path, graphic)
    }
}