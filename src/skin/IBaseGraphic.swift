
import Foundation

protocol IBaseGraphic {
    var lineStyle:ILineStyle?{get}
    var fillStyle:IFillStyle?{get}
    func setProperties(fillStyle:IFillStyle?, lineStyle:ILineStyle?)
    func setPosition(position:CGPoint)
    /*var lineOffsetType:OffsetType{get set}*/
}
