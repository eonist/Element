import Foundation

protocol SlidableScrollable2:Slidable2,Scrollable2{}

extension SlidableScrollable2{
    func scroll(_ event: String) {
        if(event == "change"){
            Swift.print("🏂📜 SlidableScrollable slider.setProgress(\(event))")
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
