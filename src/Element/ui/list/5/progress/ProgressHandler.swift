import Foundation
@testable import Utils

class ProgressHandler {
    var contentContainer:Element {get{return list.contentContainer}/*set{list.contentContainer = newValue}*/}
    var maskSize:CGSize {get{return list.maskSize}/*set{list.maskSize = newValue}*/}
    var contentSize:CGSize {get{return list.contentSize}/*set{list.contentSize = newValue}*/}
    //
    var list:Listable5
    init(list:Listable5){
        self.list = list
    }
    var itemSize:CGSize {fatalError("must be overriden in subclass")/*return CGSize(24,24)*/}//temp, use a static interval like 4 or 8, then use itemsize only for listable etc
    func interval(_ dir:Dir) -> CGFloat{return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
    func progress(_ dir:Dir) -> CGFloat{return SliderParser.progress(contentContainer.layer!.position[dir], maskSize[dir], contentSize[dir])}
    var interval:CGPoint {return CGPoint(interval(.hor),interval(.ver))}//convenience
    var progress:CGPoint {return CGPoint(progress(.hor),progress(.ver))}//convenience
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
        //Swift.print("Progressable3.setProgress: " + " progress: \(progress) dir: \(dir)")
        let progressValue = contentSize[dir] < maskSize[dir] ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        ScrollableUtils.scrollTo(list,progressValue,dir)
    }
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ p:CGPoint){
        //Swift.print("Progressable3.setProgress: " + "\(point)")
        setProgress(p.x,.hor)
        setProgress(p.y,.ver)
    }
}

extension ScrollableUtils{//temp migration fix
    /**
     * NOTE: I'm unsure if disabling anim on the container.y pos is needed
     */
    static func scrollTo(_ containable:Containable5, _ progress:CGFloat, _ dir:Dir = .ver){
        let val:CGFloat = ScrollableUtils.scrollTo(progress, containable.maskSize[dir], containable.contentSize[dir])
        disableAnim {(containable.contentContainer as! Container).layerPos(val,dir)}/*we offset the y position of the lableContainer*/
    }
}
