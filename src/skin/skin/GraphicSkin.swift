import Foundation


class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
    }
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("GraphicSkin.drawRect()")
        graphic.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
    }
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw() NOT IMPLEMENTED YET")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            
        }
        super.draw();
    }
    func applyProperties(decoratable:IGraphicDecoratable){
        //Swift.print("GraphicSkin.applyProperties() NOT IMPLEMENTED YET")
    }
}