import Foundation
@testable import Utils

class ProgressHandler:ProgressableDecorator {
    var progressable:Progressable5
    init(progressable:Progressable5){
        self.progressable = progressable
    }
    func interval(_ dir:Dir) -> CGFloat{return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
    func progress(_ dir:Dir) -> CGFloat{
        let sliderProgress:CGFloat = SliderParser.progress(contentContainer.layer!.position[dir], maskSize[dir], contentSize[dir])
        return sliderProgress
    }
    var interval:CGPoint {return CGPoint(interval(.hor),interval(.ver))}//convenience
    var progress:CGPoint {return CGPoint(progress(.hor),progress(.ver))}//convenience
    
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ p:CGPoint){
//        Swift.print("ProgressHandler.setProgress: " + "\(p)")
        setProgress(p.x, .hor)
        setProgress(p.y,.ver)
    }
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
//        Swift.print("ProgressHandler.setProgress: " + " progress: \(progress) dir: \(dir)")
        let progressValue = contentSize[dir] < maskSize[dir] ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
//        Swift.print("progressValue: " + "\(progressValue)")
        ScrollableUtils.scrollTo(progressable,progressValue,dir)
    }
}
extension ScrollableUtils{//temp migration fix
    /**
     * NOTE: I'm unsure if disabling anim on the container.y pos is needed
     */
    static func scrollTo(_ containable:Containable5, _ progress:CGFloat, _ dir:Dir){
//        Swift.print("scrollTo")
        let val:CGFloat = ScrollableUtils.scrollTo(progress, containable.maskSize[dir], containable.contentSize[dir])
//        Swift.print("val: " + "\(val)")
        containable.contentContainer.layer?.position[dir] = val/*we offset the y position of the lableContainer*/
    }
}
