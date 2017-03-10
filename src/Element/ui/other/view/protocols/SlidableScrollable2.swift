import Foundation

protocol SlidableScrollable2:Slidable2,Scrollable2{}

extension SlidableScrollable2{
    func scroll(_ event: String) {
        if(event == "change"){
            Swift.print("🏂📜 SlidableScrollable slider.setProgress(\(event))")
        }
        (self as Scrollable).scroll(event)
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func onScrollWheelExit() {
        hideSlider()
    }
}
