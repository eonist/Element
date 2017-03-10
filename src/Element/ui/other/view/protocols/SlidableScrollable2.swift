import Cocoa

protocol SlidableScrollable2:Slidable2,Scrollable2{}

extension SlidableScrollable2{
    func scroll(_ event: NSEvent) {
        if(event.phase == NSEventPhase.changed){
            Swift.print("🏂📜 SlidableScrollable slider.setProgress(\(event))")
            let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
            slider!.setProgressValue(progress)
        }
        (self as Scrollable2).scroll(event)//protocol ambiguity, side-ways inheritance
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func onScrollWheelExit() {
        hideSlider()
    }
}
