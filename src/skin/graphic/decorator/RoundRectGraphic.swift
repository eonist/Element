import Foundation

class RoundRectGraphic:GraphicDecoratable{//adds round-rectangular path
    var fillet:Fillet;
    init(_ decoratable: IGraphicDecoratable,  _ fillet:Fillet) {
        self.fillet = fillet
        super.init(decoratable)
    }
    override func drawFill() {
        let x:CGFloat = graphic.lineOffsetType!.left == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        let y:CGFloat = graphic.lineOffsetType!.top == OffsetType.outside ? graphic.lineStyle!.thickness : 0;
        //Swift.print("RoundRectGraphic2.drawFill() ")
        let w:CGFloat = getGraphic().width
        //Swift.print("w: " + "\(w)")
        let h:CGFloat = getGraphic().height
        //Swift.print("h: " + "\(h)")
        //Swift.print("fillet.topLeft: " + "\(fillet.topLeft)")
        getGraphic().path = CGPathParser.roundRect(x,y,w, h,fillet.topLeft, fillet.topRight, fillet.bottomLeft, fillet.bottomRight)//Shapes
    }
    /**
     *
     */
    override func drawLine(){
        
        if(graphic.lineStyle != nil){/*updates only if lineStyle and lineStyle.color are valid*/// :TODO: this check could possibly be redundant
            let lineOffsetType:OffsetType = graphic.lineOffsetType!;
            let rect:CGRect = RectGraphicUtils.offsetRect(CGRect(0, 0, graphic.width, graphic.height), graphic.lineStyle!, lineOffsetType);
            let fillet:Fillet = FilletParser.config(self.fillet, lineOffsetType, graphic.lineStyle!);
            CGPathParser.roundRect(rect.x,rect.y,rect.width,rect.height,fillet.topLeft, fillet.topRight, fillet.bottomLeft, fillet.bottomRight)
            /*mask*/
            let maskRect:CGRect = RectGraphicUtils.maskRect(CGRect(0,0,graphic.width,graphic.height), graphic.lineStyle!, lineOffsetType);
        }
        /*
        
        
        
        
        graphic.lineMask.graphics.beginFill(Color.GREEN,0.5);
        var maskFillet:Fillet = Rect3Utils.configMaskFillet(_fillet, lineOffsetType, graphic.lineStyle);
        graphic.lineMask.graphics.drawRoundRectComplex(maskRect.x, maskRect.y, maskRect.width, maskRect.height, maskFillet.topLeft, maskFillet.topRight, maskFillet.bottomLeft, maskFillet.bottomRight);
        graphic.lineMask.graphics.endFill();
        }

        */
    }
}