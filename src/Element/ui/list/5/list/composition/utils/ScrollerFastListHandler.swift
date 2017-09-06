import Cocoa
@testable import Utils

class ScrollerFastListHandler:ScrollHandler,FastListable5 {
  //fast
    var selectedIdx: Int? {get{return fastListable.selectedIdx} set{fastListable.selectedIdx = newValue}}
    var pool: [FastListItem] {get{return fastListable.pool} set{fastListable.pool = newValue}}
    var inActive: [FastListItem] {get{return fastListable.inActive} set{fastListable.inActive = newValue}}
    //List
    var dp: DataProvider {get{return fastListable.dp}}
    var dir: Dir {get{return fastListable.dir}}
    func reUse(_ listItem: FastListItem) {
        fastListable.reUse(listItem)
    }
    func createItem(_ index: Int) -> Element {
        return  fastListable.createItem(index)
    }
    //override scroll i think?, make sure fastlist gets its setporgress 🏀
    
    var fastListable:FastListable5 {return progressable as! FastListable5}
    
    override func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("ScrollerFastListHandler.onScrollWheelChange")
//        super.onScrollWheelChange(event)
        //Swift.print("ScrollableFastListable3.onScrollWheelChange()")
        let primaryProgress:CGFloat = SliderListUtils.progress(event, dir, interval(dir), progress(dir))
        // setProgress(primaryProgress)//TODO: ⚠️️ this is not good. that you have to call setProgress one after the other.
        super.setProgress(primaryProgress,dir)//we move the containerView as normal
        (fastListable as? FastList5)?.setProgress(primaryProgress)//we use the pos of containerView to move the fastList items around
        //        ScrollFastList3.numOfEvents! += 1
    }
}
