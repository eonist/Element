import Foundation
/**
 * These are the methods the GraphicDecoratable must implement
 * Differs from IBaseGraphic in that IBaseGraphic has some variables that the decoratables isnt dependent on when it comes to the creation procedure
 */
protocol IGraphicDecoratable:IPositional,ISizeable{
    var graphic:BaseGraphic{get}
    func getGraphic() -> BaseGraphic/*Dont revert this variable to a protocol*/
    /*Design*/
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func line()
    func applyLineStyle()
    func drawLine()
    func stylizeLine()
    func initialize()
    /*Size & position*/
    var size:CGSize{get set}
    var position:CGPoint{get set}
    func getSize()->CGSize
    func getPosition()->CGPoint
    func setSize(size:CGSize)
    func setPosition(position:CGPoint)
}