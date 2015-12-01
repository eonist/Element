import Cocoa
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic {
    /*var size:CGSize*/
    init(_ position:CGPoint, _ size:CGSize, _ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {
        super.init(position,decoratable)
        super.size = size
    }
    override func getSize() -> CGSize {
        return size
    }
}
extension SizeableGraphic{
    convenience init(_ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100,_ decoratable: IGraphicDecoratable){
        self.init(CGPoint(0,0),CGSize(width,height),decoratable)
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100){
        self.init(CGPoint(0,0),CGSize(width,height))
    }
}