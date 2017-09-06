import Foundation
@testable import Utils

protocol Progressable5:Containable5{
    func progress(_ dir:Dir) -> CGFloat/*0-1 atBegining <-> atEnd*/
    func interval(_ dir:Dir) -> CGFloat/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir)
    //func setProgress(_ point:CGPoint)
    var itemSize:CGSize {get}
}
