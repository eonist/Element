import Foundation

/**
 * The responsibility of this class is to provide access to the position of the PositionalGraphic
 */
class PositionalDecorator:GraphicDecoratable,IPositional{
    var position:CGPoint{
        get{
            if(decoratable is PositionalGraphic){return (decoratable as! PositionalGraphic).position}
            else{fatalError("Must subclass PositionalGraphic")}
        }
        set{
            if(decoratable is PositionalGraphic){(decoratable as! PositionalGraphic).position = newValue}
            else{fatalError("Must subclass PositionalGraphic")}
        }
    }
    func getPosition() -> CGPoint {
        return position
    }
}