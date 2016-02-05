import Cocoa
/*
 * All SizableGraphics are also positionable
 */
class SizeableGraphic:PositionalGraphic,ISizeable {
    var size:CGSize
    var trackingArea:NSTrackingArea?
    init(_ position:CGPoint, _ size:CGSize, _ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.redColor()))) {//TODO:add the last arg through an extension?
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
/**
 * Convenience init methods
 * TODO: Add explination and example code for each init
 */
extension SizeableGraphic{
    /*Gradient fill initializers*/
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle?/*?*/, _ gradientLineStyle:GradientLineStyle/*?*/, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and Gradient stroke*/
        //Swift.print("Init with none Fill and gradient line")
        self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle/*?*/, _ gradientLineStyle:GradientLineStyle?/*?*/, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/*Gradient fill and Gradient stroke*/
        //Swift.print("Init with gradientFill and none line")
        self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(gradientFillStyle,gradientLineStyle,lineOffset)))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ fillStyle:FillStyle/*?*/, _ gradientLineStyle:GradientLineStyle/*?*/, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/* Gradient fill and color stroke*/
        //Swift.print("Init with color Fill and gradient line")
        self.init(CGPoint(x,y),CGSize(width,height),GradientGraphic(BaseGraphic(fillStyle,gradientLineStyle,lineOffset)))
    }
    convenience init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat, _ height:CGFloat,_ gradientFillStyle:GradientFillStyle/*?*/, _ lineStyle:ILineStyle/*?*/, _ lineOffset:OffsetType = OffsetType(OffsetType.center)){/* Gradient fill and color stroke*/
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
    convenience init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat,_ height:CGFloat,_ fillColor:NSColor){
        self.init(CGPoint(x,y),CGSize(width,height),BaseGraphic(FillStyle(fillColor)))
    }
    convenience init(_ width:CGFloat, _ height:CGFloat, _ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        self.init(CGPoint(0,0),CGSize(width,height),BaseGraphic(fillStyle,lineStyle))
    }
    convenience init(_ width:CGFloat = 100, _ height:CGFloat = 100,_ decoratable:IGraphicDecoratable){
        self.init(CGPoint(0,0),CGSize(width,height),decoratable)
    }
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
extension SizeableGraphic{
    /**
     * NOTE: you should use bounds for the rect but we dont rotate the frame so we dont need to use bounds.
     * NOTE: the only way to update trackingArea is to remove it and add a new one
     * PARAM: owner is the instance that receives the interaction event
     * NOTE: we could keep the trackingArea in graphic so its always easy to access, but i dont think it needs to be easily accesible atm.
     */
    func updateNSTrackingArea(owner:AnyObject?){
        if(trackingArea != nil) {graphic.removeTrackingArea(trackingArea!)}//remove old trackingArea if it exists
        trackingArea = NSTrackingArea(rect: NSRect(pos.x,pos.y,size.width,size.height), options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: owner, userInfo: nil)
        graphic.addTrackingArea(trackingArea!)//<---this will be in the Skin class in the future and the owner will be set to Element to get interactive events etc
    }
}


//continue here: 

//there is a problem with keeping updateTracking area here. the graphic may not have been added to its parent yet. 
//Check if draw() needs the same condition. If it doesnt then maybe use that. Or implement a selctor type of scheme to trigger updateTrackingRect from the updateTrackingARea in the graphic class.
// all this seems redundant if you could only set the Graphic to a frame size. I mean, all graphics has frameSize, even line
//after a test, draw does not garantue that a parent is present. 

//look at the code that has to do with setting the frameSize of RoundRect etc. Toy with the idea of storing size and pos in the frame of the graphic. and having different methods for updating size retrieving size and setting size.



