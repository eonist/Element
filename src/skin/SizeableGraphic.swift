import Cocoa
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeable {
    var size:CGSize
    init(_ position:CGPoint, _ size:CGSize, _ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {
        self.size = size
        super.init(position,decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getSize() -> CGSize {
        return size
    }
    func setSizeValue(size: CGSize) {/*<- was named setSize, but objc doesnt allow it*/
        self.size = size
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
    convenience init(_ rect:NSRect, _ decoratable: IGraphicDecoratable){
        self.init(rect.origin,rect.size,decoratable)
    }
    convenience init(_ rect:NSRect, _ fillStyle:IFillStyle, lineStyle:ILineStyle){
        
        self.init(rect.origin,rect.size,BaseGraphic(fillStyle))
    }
}

