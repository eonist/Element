import Cocoa

protocol SlidableScrollable2:Slidable2,Scrollable2{}

extension SlidableScrollable2{
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("🏂📜 SlidableScrollable2.onScrollWheelChange: \(event)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, progress)
        slider!.setProgressValue(progress)
        setProgress(progressVal)/*<-faux progress, its caluclated via delta noramlly*/
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func onScrollWheelExit() {
        hideSlider()
    }
}
