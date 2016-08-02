import Foundation

/**
 * The responsibility of this class is to provide access to the position of the PositionalGraphic
 * NOTE: the if else clauses doesnt look good, but swift doesnt allow setting values via protocols that uses extensions for its functionality, so its eigther this or implementing implicit setter method in each subclass conforming to IPositional
 */
class PositionalDecorator:GraphicDecoratable,IPositional{
    var pos:CGPoint{
        get{
            if(decoratable is IPositional){return (decoratable as! IPositional).pos}
            else{fatalError("Must subclass PositionalGraphic")}
        }
        set{
            if(decoratable is PositionalGraphic){(decoratable as! PositionalGraphic).pos = newValue}
            else if(decoratable is IPositional){(decoratable as! IPositional).pos = newValue}
            else{fatalError("Must subclass PositionalGraphic")}
        }
    }
    /**
     * NOTE: This method must remain an instance method so that other decorators can override it (Circle, Line, Path, etc)
     */
    func getPosition() -> CGPoint {
        return pos
    }
    func setPosition(position: CGPoint) {
        self.pos = position
    }
}