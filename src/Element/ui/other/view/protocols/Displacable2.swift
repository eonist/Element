import Foundation

protocol Displacable2 {
    var height:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemHeight:CGFloat{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    var progress:CGFloat {get}
    var itemContainer:Element {get}
}
extension Displacable2{
    func setProgress(_ progress:CGFloat){
        print("🖼️ moving itemContainer up and down progress: \(progress)")
    }
}
