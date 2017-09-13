import Cocoa
@testable import Utils

class ProgressableView5:ContainerView5,Progressable5 {
    lazy var handler:ProgressHandler = .init(progressable:self)//⚠️️ rename to handler and make it override somehow
    //
    var itemSize:CGSize {return CGSize(24,24)}//sort of a quick fix, one should really override interval with a value of 4 or 10 or something
    func progress(_ dir:Dir) -> CGFloat {return handler.progress(dir)}
    func interval(_ dir:Dir) -> CGFloat {return handler.interval(dir)}/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir) {
        handler.setProgress(progress, dir)
    }
    func setProgress(_ point:CGPoint) {
        handler.setProgress(point)
    }
}
