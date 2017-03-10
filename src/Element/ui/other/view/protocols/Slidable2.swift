import Foundation

protocol Slidable2:Displacable2{
    var interval:CGFloat {get}
    func updateSlider()
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
