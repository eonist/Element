import Foundation
/*
* 
*/
protocol IGraphic{
    var lineStyle:ILineStyle?{get}
    var fillStyle:IFillStyle?{get}
    var lineOffsetType:OffsetType{get set}
}