import Foundation

class PositionalGraphic:GraphicDecoratable {
    var position:CGPoint
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        super.init(decoratable)
        super.position = position
    }
    override func setPosition(position: CGPoint) {
        //Swift.print("PositionalGraphic.setPosition()")
        self.position = position
    }
    override func getPosition() -> CGPoint {
        return position
    }
}


class PositionalDecorator:GraphicDecoratable,IPositional{
    var position:CGPoint{
        get{
            if(decoratable is PositionalGraphic){
               return (decoratable as! PositionalGraphic).position
            }else{
                fatalError("")
            }
            
        }
        set{
            (decoratable as! PositionalGraphic).position = newValue
        }
    }
    
    /*
    func test(){
        if (decoratable is PositionalGraphic){
            (decoratable as! PositionalGraphic).position = CGPoint()
        }
    }
    */
}