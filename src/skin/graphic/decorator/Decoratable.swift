import Foundation

class Decoratable:IDecoratable{
    var decoratable:IDecoratable
    init(decoratable:IDecoratable){
        self.decoratable = decoratable;
    }
    func fill(){
        fatalError("must be overriden in subclass");
    }
    func line(){
        fatalError("must be overriden in subclass");
    }
    func clear(){
        fatalError("must be overriden in subclass");
    }
    func clearLine(){
        fatalError("must be overriden in subclass");
    }
    func drawFill() {
        fatalError("must be overriden in subclass");
    }
    func drawLine() {
        fatalError("must be overriden in subclass");
    }
    func beginFill() {// :TODO: rename to applyFill? its more consistent with applyLine
        fatalError("must be overriden in subclass");
    }
    func applyLineStyle(graphics:Graphics,lineStyle:ILineStyle) {// :TODO: rename to applyLine?
        fatalError("must be overriden in subclass");
    }
    func endFill(){
        fatalError("must be overriden in subclass");
    }
    /**
     * Returns _decoratable.graphic
     * @Note: we use decoratable.graphic to get to the graphics object, regardless of how many layers of decorators above.
     */
    func getGraphic()-> Graphic {
        return decoratable.getGraphic();
    }
}