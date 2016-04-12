import Cocoa
/**
 * NOTE: It isnt ideal that you have to extend PositionalDecorator instead of simply GraphicDecorable, but in the spirit of moving on we keep it as is
 */
class DropShadowDecorator:SizeableDecorator{//TODO: probably should extend SizeableDecorator, so that we can resize the entire Decorator structure 
    var dropShadow:DropShadow?
    init(_ decoratable: IGraphicDecoratable,_ dropShadow:DropShadow?) {
        self.dropShadow = dropShadow
        super.init(decoratable)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override func fill() {
        //Swift.print("DropShadowDecorator.fill()")
        if(dropShadow != nil && dropShadow!.inner){/*inner*/
            graphic.fillShape.graphics.dropShadow = dropShadow
        }else if(dropShadow != nil && !dropShadow!.inner){/*outer*/
            graphic.layer!.shadowColor = dropShadow!.color.cgColor//dont forget about the graphic.layer!.shadowPath
            graphic.layer!.shadowOpacity = dropShadow!.color.alphaComponent.float
            graphic.layer!.shadowRadius = dropShadow!.blurRadius
            graphic.layer!.shadowOffset = dropShadow!.offset
        }else{/*no shadow*/
            graphic.fillShape.graphics.dropShadow = nil
            graphic.layer!.shadowColor = NSColor.clearColor().CGColor
            graphic.layer!.shadowOpacity = 0.0
            graphic.layer!.shadowRadius = 0.0
            graphic.layer!.shadowOffset = CGSizeMake(0, 0)
        }
        
        //Swift.print(graphic.graphics.dropShadow)
        super.fill()
    }
}