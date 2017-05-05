import Cocoa
@testable import Utils
@testable import Element

protocol Progressable3:Containable3{
    func progress(_ dir:Dir) -> CGFloat/*0-1 atBegining <-> atEnd*/
    func interval(_ dir:Dir) -> CGFloat/*describes the speed when scrolling (distance per scroll tick)*/
    func setProgress(_ progress:CGFloat,_ dir:Dir)
    //func setProgress(_ point:CGPoint)
    var itemSize:CGSize {get}
}
extension Progressable3{
    var itemSize:CGSize {fatalError("must be overriden in subclass")/*return CGSize(24,24)*/}//temp, use a static interval like 4 or 8, then use itemsize only for listable etc
    func interval(_ dir:Dir) -> CGFloat{return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
    func progress(_ dir:Dir) -> CGFloat{return SliderParser.progress(contentContainer!.point[dir], maskSize[dir], contentSize[dir])}
    var interval:CGPoint {return CGPoint(interval(.hor),interval(.ver))}//convenience
    var progress:CGPoint {return CGPoint(progress(.hor),progress(.ver))}//convenience
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
        //Swift.print("Progressable3.setProgress: " + " progress: \(progress) dir: \(dir)")
        let progressValue = self.contentSize[dir] < maskSize[dir] ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        ScrollableUtils.scrollTo(self,progressValue,dir)
    }
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ point:CGPoint){
        //Swift.print("Progressable3.setProgress: " + "\(point)")
        setProgress(point.x,.hor)
        setProgress(point.y,.ver)
    }
}
private extension ScrollableUtils{//temp migration fix
    static func scrollTo(_ containable:Containable3, _ progress:CGFloat, _ dir:Dir = .ver){
        let val:CGFloat = ScrollableUtils.scrollTo(progress, containable.maskSize[dir], containable.contentSize[dir])
        //Swift.print("val: " + "\(val)")
        containable.contentContainer!.point[dir] = val/*we offset the y position of the lableContainer*/
    }
}
