import Foundation

protocol IPositionalGraphic {
    var x:CGFloat{get set}
    var y:CGFloat{get set}
}
extension IPositionalGraphic{
    /**
     * TODO: remove the x and y values from this class, some graphics may not have a natural x and y pos like LineGraphic or PathGraphic
     */
}