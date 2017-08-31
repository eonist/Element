import Foundation
@testable import Utils

extension GraphicSkin{
    /**
     * Draws decoratable
     */
    func drawDecoratable(_ depth:Int){
        if hasChanged.size {
            GraphicSkinModifier.setSize(decoratables[depth], GraphicSkinParser.size(self,depth))
        }/*Do sizing of the sizable here*/
        if hasChanged.state || hasChanged.style {
            updateAppearance(decoratables[depth], depth)
        }
        if hasChanged.size || hasChanged.state || hasChanged.style {
            decoratables[depth].draw()/*<--Init the actual draw call, you only want to draw once bc performance*/
        }
    }
    /**
     * Refreshes the look of the "decoratable"
     */
    func updateAppearance(_ decoratable:GraphicDecoratableKind,_ depth:Int){
        GraphicSkinModifier.applyStyle(decoratable,self,depth)/*derives and applies style to the decoratable*/
        decoratable.get(RectGraphic.self)?.setSizeValue(GraphicSkinParser.size(self,depth))
        decoratable.get(RoundRectGraphic.self)?.fillet = StyleMetricParser.fillet(self,depth)/*fillet*/
        decoratable.get(AssetDecorator.self)?.assetURL = StylePropertyParser.asset(self,depth)/*Svg*/
        decoratable.get(DropShadowDecorator.self)?.dropShadow = StylePropertyParser.dropShadow(self,depth)/*dropshadow*/
        GraphicSkinModifier.setRotation(decoratable, self, depth)
        _ = SkinModifier.align(self,decoratables[depth] as! Positional,depth)
    }
}
