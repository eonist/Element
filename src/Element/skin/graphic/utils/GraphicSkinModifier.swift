import Foundation
@testable import Utils

class GraphicSkinModifier{
    /**
     * beta
     */
    static func setSize(_ sizableDecorator:GraphicDecoratableKind,_ size:CGSize){
        (sizableDecorator as! Sizable).setSizeValue(size)
        //sizableDecorator.draw()
    }
    static func setRotation(_ decoratable:GraphicDecoratableKind,_ skin:Skinable,_ depth:Int){
        if let rotation:CGFloat = StyleMetricParser.rotation(skin,depth){
            let size:CGSize = (decoratable as! Sizable).size
            let pos:CGPoint = (decoratable as! Positional).pos
            let rect:CGRect = CGRect(pos, size)
            disableAnim{
                GraphicModifier.applyRotation(decoratable, rotation, rect.center)
            }
        }
    }
    /**
     * Applies style and lineOffset
     */
    static func applyStyle(_ decoratable:GraphicDecoratableKind, _ graphicSkin:GraphicSkin,_ depth:Int){
        let fillStyle:FillStyleKind = StylePropertyParser.fillStyle(graphicSkin,depth)
        let lineStyle:LineStylable? = StylePropertyParser.lineStyle(graphicSkin,depth)
        let lineOffsetType = StylePropertyParser.lineOffsetType(graphicSkin,depth)
        _ = GraphicModifier.applyProperties(decoratable,fillStyle ,lineStyle ,lineOffsetType)/*color or gradient*/
    }
}
