import Foundation

class IGraphic{
    func lineShape():Shape;
    func  lineStyle():ILineStyle{get};
    func  fillStyle():IFillStyle{get}
    func  lineOffsetType():OffsetType[get];
    func  lineOffsetType(offsetType : OffsetType) : void
    func get graphics():Graphics;
}