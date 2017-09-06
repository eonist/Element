import Foundation
@testable import Utils

protocol ProgressableDecorator:Progressable5 {
    var progressable:Progressable5 {get}
}
extension ProgressableDecorator{
    func progress(_ dir:Dir) -> CGFloat {return progressable.progress(dir)}
    func interval(_ dir:Dir) -> CGFloat {return progressable.interval(dir)}/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir) {progressable.setProgress(progress, dir)}
    //
    //⚠️️ maybe move to ContainableDecorator?
    var contentContainer:Element {get{return progressable.contentContainer}/*set{list.contentContainer = newValue}*/}
    var maskSize:CGSize {get{return progressable.maskSize}/*set{list.maskSize = newValue}*/}
    var contentSize:CGSize {get{return progressable.contentSize}/*set{list.contentSize = newValue}*/}
    var itemSize:CGSize {return progressable.itemSize/*fatalError("must be overriden in subclass")*//*return CGSize(24,24)*/}//temp, use a static interval like 4 or 8, then use itemsize only for listable etc
}
