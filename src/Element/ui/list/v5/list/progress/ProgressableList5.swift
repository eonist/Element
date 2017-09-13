import Cocoa
@testable import Utils

class ProgressableList5:List5,Progressable5 {
    var progressable:Progressable5 {return self}//move this somewhere else
    lazy var handler:ProgressHandler = .init(progressable:self)
    //
    func progress(_ dir:Dir) -> CGFloat {return handler.progress(dir)}
    func interval(_ dir:Dir) -> CGFloat {return handler.interval(dir)}/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir) {
        handler.setProgress(progress, dir)
    }
    func setProgress(_ point:CGPoint) {
        handler.setProgress(point)
    }
}
