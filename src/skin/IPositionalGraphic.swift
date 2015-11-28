import Foundation

protocol IPositionalGraphic:IGraphicDecoratable {/*We need the getGraphic() from IGraphicDecoratable*/
    var x:CGFloat{get set}
    var y:CGFloat{get set}
}
extension IPositionalGraphic{
    var x:CGFloat{get{return getGraphic().x}set{getGraphic().x = newValue}}
    var y:CGFloat{get{return getGraphic().y}set{getGraphic().y = newValue}}
    /**
     *
     */
    func setPosition(position:CGPoint){
        getGraphic().setPosition(position)
    }
}