import Foundation
@testable import Element
@testable import Utils

protocol Elastic2:Containable2{
    var mover:RubberBand?{get set}
    var iterimScroll:InterimScroll{get set}
}
extension Elastic2{
    func setProgress(_ value:CGFloat){
        contentContainer!.frame.x = value/*<--this is where we actully move the labelContainer*/
        //progressValue = value / -(contentSize.width - maskSize.width)/*get the the scalar values from value.*/
    }
}
