
import Foundation

protocol IBaseGraphic {
    var width:Double{get}
    var height:Double{get}
    var lineStyle:ILineStyle?{get}
    var fillStyle:IFillStyle?{get}
    func setProperties(fillStyle:IFillStyle?, lineStyle:ILineStyle?)
    func setPosition(position:CGPoint)
    /*var lineOffsetType:OffsetType{get set}*/
}
