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
    func getSize() -> CGSize {
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


/**
 * Shorten the bellow code with if shorthand
 */
class SizableDecorator:PositionalDecorator,ISizeable{
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