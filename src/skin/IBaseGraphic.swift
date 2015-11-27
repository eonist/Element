
import Foundation

protocol IBaseGraphic {
    /*
    var width:CGFloat{get}
    var height:CGFloat{get}
    */
    var lineStyle:ILineStyle?{get}
    var fillStyle:IFillStyle?{get}
    func setProperties(fillStyle:IFillStyle?, lineStyle:ILineStyle?)
    func setPosition(position:CGPoint)
    var lineOffsetType:OffsetType?{get set}
    var path:CGMutablePath{get set}
    var linePath:CGMutablePath{get set}
}
