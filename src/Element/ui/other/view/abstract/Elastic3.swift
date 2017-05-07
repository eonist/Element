import Cocoa
@testable import Utils

protocol Elastic3:Progressable3{
    var moverGroup:MoverGroup? {get}
    //var iterimScrollGroup:IterimScrollGroup? {get}
}
extension Elastic3{
    /**
     * PARAM: value: contentContainer x/y value
     */
    func setProgress(_ value:CGFloat,_ dir:Dir){
        //Swift.print("Elastic3.setProgress(value)")
        //contentContainer!.point[dir] = value
        disableAnim {
            contentContainer?.layer?.position[dir] = value
        }
        
    }
    func setProgress(_ point:CGPoint){
        //Swift.print("Elastic3.setProgress(\(point))")
        //contentContainer!.point = point
        disableAnim {
            contentContainer?.layer?.position = point
        }
        
    }
}
