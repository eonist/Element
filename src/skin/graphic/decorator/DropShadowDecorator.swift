import Cocoa
/**
 * NOTE: It isn't ideal that you have to extend PositionalDecorator instead of simply GraphicDecorable, but in the spirit of moving on we keep it as is
 * TODO: Why did you stop using the Graphics outer shadow and start using the layer outer shadow?
 */
class DropShadowDecorator:SizeableDecorator{//TODO: probably should extend SizeableDecorator, so that we can resize the entire Decorator structure 
    var dropShadow:DropShadow?
    init(_ decoratable: IGraphicDecoratable,_ dropShadow:DropShadow?) {
        //Swift.print("DropShadowDecorator.init()")
        self.dropShadow = dropShadow
        super.init(decoratable)
    }
    override func fill() {
        //Swift.print("DropShadowDecorator.fill()")
        if(dropShadow != nil && dropShadow!.inner){/*Inner*/
            graphic.fillShape.graphics.dropShadow = dropShadow
        }else if(dropShadow != nil && !dropShadow!.inner){/*Outer*/
            graphic.layer!.shadowColor = dropShadow!.color.cgColor//don't forget about the graphic.layer!.shadowPath
            graphic.layer!.shadowOpacity = dropShadow!.color.alphaComponent.float
            //Swift.print("dropShadow!.blurRadius: " + "\(dropShadow!.blurRadius)")
            graphic.layer!.shadowRadius = dropShadow!.blurRadius
            graphic.layer!.shadowOffset = dropShadow!.offset
        }else{/*No shadow*/
            graphic.fillShape.graphics.dropShadow = nil
            graphic.layer!.shadowColor = NSColor.clearColor().CGColor
            graphic.layer!.shadowOpacity = 0.0
            graphic.layer!.shadowRadius = 0.0
            graphic.layer!.shadowOffset = CGSizeMake(0, 0)
        }
        //Swift.print(graphic.graphics.dropShadow)
        super.fill()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}