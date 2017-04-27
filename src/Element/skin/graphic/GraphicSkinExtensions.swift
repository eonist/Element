import Foundation

extension GraphicSkin{
    /**
     * Draws decoratable
     */
    func drawDecoratable(_ depth:Int){
        if(hasSizeChanged){
            let padding:Padding = Padding()//StylePropertyParser.padding(self,depth);// :TODO: what about margin?<----not sure this is needed, the padding
            Modifier.reSize(decoratables[depth], CGSize(width! + padding.left + padding.right, height! + padding.top + padding.bottom))
        }//Do sizing of the sizable here
        if(hasStateChanged || hasStyleChanged) {
            updateAppearance(&decoratables[depth],depth)
        }
        if(hasSizeChanged || hasStateChanged || hasStyleChanged){
            decoratables[depth].draw()/*<--Init the actual draw call, you only want to draw once bc performance*/
        }
    }
    /**
     * Refreshes the look of the "layer"
     */
    func updateAppearance(_ decoratable:inout IGraphicDecoratable,_ depth:Int){
        Swift.print("refreshLayer")
        Modifier.applyStyle(&decoratable,self,depth)/*derives and applies style to the decoratable*/
        decoratable.get(RectGraphic.self)?.setSizeValue(Parser.size(self,depth))
        decoratable.get(RoundRectGraphic.self)?.fillet = StylePropertyParser.fillet(self,depth)/*fillet*/
        decoratable.get(AssetDecorator.self)?.assetURL = StylePropertyParser.asset(self,depth)/*Svg*/
        decoratable.get(DropShadowDecorator.self)?.dropShadow = StylePropertyParser.dropShadow(self,depth)/*dropshadow*/
        Modifier.rotate(&decoratable, self, depth)
        _ = SkinModifier.align(self,decoratables[depth] as! IPositional,depth)
    }
}


/**
 * Parser for "decoratable"
 */
private class Parser{
    /**
     * TODO: should just use the instance setSize function
     * TODO: should only be called if the size has actually changed
     */
    static func size(_ skin:ISkin,_ depth:Int)->CGSize{
        let padding:Padding = Padding()//StylePropertyParser.padding(self,depth)
        let width:CGFloat = Parser.width(skin,depth,padding)
        let height:CGFloat = Parser.height(skin,depth,padding)
        return CGSize(width,height)
    }
    static func width(_ skin:ISkin,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StylePropertyParser.width(skin,depth) ?? skin.width!) + padding.hor// :TODO: only querry this if the size has changed?
    }
    static func height(_ skin:ISkin,_ depth:Int, _ padding:Padding) -> CGFloat {
        return (StylePropertyParser.height(skin,depth) ?? skin.height!) + padding.ver// :TODO: only querry this if the size has changed?
    }
}
private class Modifier{
    /**
     * beta
     * TODO: move to DecoratorModifier.swift
     */
    static func reSize(_ sizableDecorator:IGraphicDecoratable,_ size:CGSize){
        (sizableDecorator as! ISizeable).setSizeValue(size)
        //sizableDecorator.draw()
    }
    static func rotate(_ decoratable:inout IGraphicDecoratable,_ skin:ISkin,_ depth:Int){
        if let rotation:CGFloat = StylePropertyParser.rotation(skin,depth){
            let size:CGSize = (decoratable as! ISizeable).size
            let pos:CGPoint = (decoratable as! IPositional).pos
            let rect:CGRect = CGRect(pos, size)
            GraphicModifier.applyRotation(&decoratable, rotation, rect.center)
        }
    }
    /**
     * Applies style and lineOffset
     */
    static func applyStyle(_ decoratable:inout IGraphicDecoratable, _ graphicSkin:GraphicSkin,_ depth:Int){
        let fillStyle = StylePropertyParser.fillStyle(graphicSkin,depth)
        let lineStyle = StylePropertyParser.lineStyle(graphicSkin,depth)
        let lineOffsetType = StylePropertyParser.lineOffsetType(graphicSkin,depth)
        _ = GraphicModifier.applyProperties(&decoratable,fillStyle ,lineStyle ,lineOffsetType)/*color or gradient*/
    }
}
