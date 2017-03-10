import Foundation

protocol Slidable2:Displacable2{
    var interval:CGFloat {get}
    func updateSlider()
    var slider:VSlider?{get}
    var sliderInterval:CGFloat?{get set}
    //func setProgress(_ progress:CGFloat)//this could go in IScrollable
    func updateSlider()
    //func scroll(_ theEvent:NSEvent)
}
extension Slidable2{
    func updateSlider(){
        //dp can update slider etc
    }
    func hideSlider(){
        Swift.print("🏂 hide slider")
    }
    func showSlider(){
        Swift.print("🏂 show slider")
    }
}
