import Cocoa
@testable import Utils

class ProgressableList5:List5,Progressable5 {
    func progress(_ dir:Dir) -> CGFloat {return handler.progress(dir)}
    func interval(_ dir:Dir) -> CGFloat {return handler.interval(dir)}/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir) {handler.setProgress(progress, dir)}
    //func setProgress(_ point:CGPoint)
    //var itemSize:CGSize {return progressHandler.itemSize}
    lazy var handler:ProgressHandler = .init(progressable:self)//⚠️️ rename to handler and make it override somehow
}
