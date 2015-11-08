import Foundation
/*
* The graphic class is an Element DataObject class that holds the lineshape, lineStyle and fillStyle
* // :TODO: possibly get rid of the setters for the fillStyle and Line style and use implicit setFillStyle and setLineStyle?
*/
class Graphic:IGraphic{//this will extend Graphics in the future
    var fillStyle:IFillStyle?
    var lineStyle:ILineStyle?
    var lineOffsetType:OffsetType
    init(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil, lineOffsetType:OffsetType = OffsetType()){
        self.fillStyle = fillStyle
        self.lineStyle = lineStyle
        self.lineOffsetType = lineOffsetType
    }
    func setPosition(position:CGPoint){
        //TODO:translate the graphics to position
    }
    func setProperties(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil){// :TODO: remove this and replace with setLineStyle and setFillStyle ?
        self.fillStyle = fillStyle;
        self.lineStyle = lineStyle;
    }
}