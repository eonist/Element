import Cocoa

class CircleGraphic:SizeableGraphic{
    var radius:CGFloat
    
    //var width:CGFloat {get{return radius!}set{fatalError("NOT SUPPORTED")}}
    //var height:CGFloat {get{return radius!}set{fatalError("NOT SUPPORTED")}}
    init(_ radius:CGFloat = 50,_ decoratable: IGraphicDecoratable = BaseGraphic(FillStyle(NSColor.greenColor()))) {
        //Swift.print("CircleGraphic.init()")
        self.radius = radius
        super.init(CGPoint(0,0),CGSize(radius,radius),decoratable)
    }
    convenience init(_ test:String){
        self.init(radius,BaseGraphic(FillStyle(fillColor)))
    }
    override func drawFill() {
        //Swift.print("CircleGraphic.drawFill()")
        getGraphic().fillShape.path = CGPathParser.circle(radius, x, y)
    }
    override func drawLine() {
        //Swift.print("CircleGraphic.drawLine()")
        graphic.lineShape.path = CGPathParser.circle(radius, x, y)
    }
    override func getSize() -> CGSize {
        return CGSize(radius,radius)
    }
}
extension CircleGraphic{
    
}