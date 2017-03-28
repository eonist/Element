import Cocoa
@testable import Utils

class ScrollList:List,Scrollable{
    var itemSize:CGSize {return CGSize(itemHeight,itemHeight)}/**///override this for custom value
    var maskSize:CGSize { get{return CGSize(width,height)}set{_ = newValue} }
    var contentSize:CGSize { get{return CGSize(dp.count * itemSize.width ,height) } set{_ = newValue}}
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("ScrollVList.onScrollWheelChange")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("ScrollVList.setProgress progress: \(progress)")
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
    }
    
    override func scrollWheel(with event:NSEvent) {
        scroll(event)
    }
    override func getClassType() -> String {
        return "VList"//"\(VList.self)"
    }
}
