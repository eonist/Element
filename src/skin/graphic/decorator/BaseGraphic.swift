import Cocoa

class BaseGraphic :AbstractGraphicDecoratable{
    var fillStyle:IFillStyle?
    var lineStyle:ILineStyle?
    lazy var graphics:Graphics = Graphics()
    var path:CGPath = CGPathCreateMutable()
    
    override func beginFill(){
        GraphicModifier.applyProperties(getGraphic().graphics, FillStyle(NSColor.purpleColor())/*, lineStyle*/)//apply style
    }
    override func stylizeFill(){
        GraphicModifier.stylize(getGraphic().path,getGraphic().graphics)//realize style on the graphic
    }
    override func getGraphic()->BaseGraphic{
        return self
    }
}
