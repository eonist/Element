import Cocoa

class GradientGraphic:GraphicDecoratable {
    override func beginFill(){
        if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {/*Updates only if fillStyle is of class FillStyle*/
            getGraphic().graphics.fill(fillStyle!.color)//Stylize the fill
        }
    }
}
