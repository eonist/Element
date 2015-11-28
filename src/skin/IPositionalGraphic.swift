import Foundation

protocol IPositionalGraphic:IPositionable {/*We need the getGraphic() from IGraphicDecoratable*/
    //the IPositionable and IGraphicDecoratable provides the properties needed
}
extension IPositionalGraphic{
    mutating func setPosition(x:CGFloat,y:CGFloat){
        self.position.x = x
        self.position.y = y
    }
}