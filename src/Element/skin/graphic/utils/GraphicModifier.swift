import Cocoa
@testable import Utils

class GraphicModifier {
    /**
     * TODO: Fill and linestyle should be graphic spessific see original code
     */
    static func applyProperties(_ decoratable:inout IGraphicDecoratable,_ fillStyle:IFillStyle,_ lineStyle:ILineStyle?,_ offsetType:OffsetType)->IGraphicDecoratable {
        decoratable.graphic.fillStyle = fillStyle
        decoratable.graphic.lineStyle = lineStyle
        decoratable.graphic.lineOffsetType = offsetType
        return decoratable
    }
    /**
     * New
     * PARAM: roation is in deg -90 90 180 0 etc
     * NOTE: possible future normalization: Trig.normalize2(rotation * ㎭)/*between -π and π*/
     */
    static func applyRotation<T:IGraphicDecoratable>(_ decoratable:inout IGraphicDecoratable,_ rotation:CGFloat){
        Swift.print("applyRotation: rotation")
        //decoratable.graphic.frameCenterRotation = rotation//(byDegrees:rotation)
        let size:CGSize = (decoratable as! ISizeable).size
        let pos:CGPoint = (decoratable as! IPositional).pos
        let rect:CGRect = CGRect(pos, size)
        decoratable.graphic.layer?.rotate(rotation, rect.center)
    }
}
