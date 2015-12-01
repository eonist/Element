import Foundation

/**
 * The responsibility of this class is to provide access to the position of the PositionalGraphic
 */
class PositionalDecorator:GraphicDecoratable,IPositional{
    var position:CGPoint{
        get{
            if(decoratable is IPositional){return (decoratable as! IPositional).position}
            else{fatalError("Must subclass PositionalGraphic")}
        }
        set{
            if(decoratable is PositionalGraphic){(decoratable as! PositionalGraphic).position = newValue}
            else if(decoratable is PositionalDecorator){(decoratable as! PositionalDecorator).position = newValue}
            else{fatalError("Must subclass PositionalGraphic")}
        }
    }
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getPosition() -> CGPoint {
        return position
    }
}