import Cocoa
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeable {
    var size:CGSize
    init(_ position:CGPoint, _ size:CGSize, _ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {//TODO:add the last arg through an extension?
        self.size = size
        super.init(position,decoratable)
    }
    /*override func draw() {
    super.draw()
    //graphic.updateTrackingArea(NSRect(pos,size))
    }*/
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getSize() -> CGSize {
        return size
    }
    func setSizeValue(size: CGSize) {/*<- was named setSize, but objc doesnt allow it*/
        self.size = size
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * Convenience init methods
 * TODO: Add explination and example code for each init
 */
extension SizeableGraphic{
    /*
     * NOTE: universal initiator for any mix of FillStyle,LineStyle,GradientFillStyle,GradientLineStyle,nil
     * NOTE: one init method that would take IFillStyle and ILineStyle and then make a if decision tree to which Graphic should be created.
     */
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ fillStyle:IFillStyle, _ lineStyle:ILineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){
        var graphic:IGraphicDecoratable
        if(fillStyle is IGradientFillStyle){
            if(lineStyle is IGradientLineStyle){graphic = GradientGraphic(BaseGraphic(fillStyle as? IGradientFillStyle,lineStyle as? IGradientLineStyle,lineOffset))}/*gradientFill,gradientLine*/
            else{graphic = GradientGraphic(BaseGraphic(fillStyle as? IGradientFillStyle,lineStyle,lineOffset))}/*gradientFill,line*/
        }else{
            if(lineStyle is IGradientLineStyle){graphic = GradientGraphic(BaseGraphic(fillStyle,lineStyle as? IGradientLineStyle,lineOffset))}/*fill,gradientLine*/
            else{graphic = BaseGraphic(fillStyle,lineStyle,lineOffset)}/*fill,line*/
        }
        self.init(CGPoint(x,y),CGSize(width,height),graphic)
    }
    convenience init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    //TODO: is this init really needed?
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100,_ decoratable:IGraphicDecoratable){
        self.init(CGPoint(0,0),CGSize(width,height),decoratable)
    }
    //TODO: I think the two bellow init methods can be merged into one, do it and test explorer if it works
    convenience init(_ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100){
        self.init(CGPoint(0,0),CGSize(width,height))//BaseGraphic(FillStyle(NSColor.redColor())
    }
    convenience init(_ rect:NSRect, _ decoratable: IGraphicDecoratable){
        self.init(rect.origin,rect.size,decoratable)
    }
}


/*
//DEPRECATED CODE:

/*Gradient fill initializers*/
/*Color fill initializers*/


/*
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle?, _ gradientLineStyle:GradientLineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and Gradient stroke*/
//Swift.print("Init with none Fill and gradient line")
self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
}
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle, _ gradientLineStyle:GradientLineStyle?, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and Gradient stroke*/
//Swift.print("Init with gradientFill and none line")
self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
}
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ fillStyle:FillStyle, _ gradientLineStyle:GradientLineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/* Gradient fill and color stroke*/
//Swift.print("Init with color Fill and gradient line")
self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(fillStyle,gradientLineStyle,lineOffset)))
}
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle, _ lineStyle:ILineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/* Gradient fill and color stroke*/
//Swift.print("Init with gradientFill and color line")
self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,lineStyle,lineOffset)))
}
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle/*?*/, _ gradientLineStyle:GradientLineStyle/*?*/, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and Gradient stroke*/
//Swift.print("Init with gradientFill and gradientLineStyle")
self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
}

/*Color fill initializers*/
convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ fillStyle:IFillStyle, _ lineStyle:ILineStyle, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){
//Swift.print("Init with Fill")
self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(fillStyle,lineStyle,lineOffset))
}
convenience init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat,_ height:CGFloat,_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(fillStyle,lineStyle))
}
convenience init(_ width:CGFloat, _ height:CGFloat, _ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(fillStyle,lineStyle))
}
*/

*/