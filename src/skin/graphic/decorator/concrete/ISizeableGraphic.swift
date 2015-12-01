import Foundation

protocol ISizeableGraphic {
    var size:CGSize {get set}
    func getSize() -> CGSize
}
extension ISizeableGraphic{
    //var sizeable:ISizeable {get{return self as ISizeable}set{}}/*This method provides support for returning a direct pointer when casting to protocol, which swift doesnt do, it only provides an immutable reference, which is unusable when setting mutating variables via extensions*/
    var width:CGFloat{get{return self.size.width} set{self.width = newValue}}
    var height:CGFloat{get{return self.size.height} set{self.height = newValue}}
    mutating func setSize(width:CGFloat,height:CGFloat){
        self.width = width
        self.height = height
    }
    mutating func setSize(size:CGSize){
        self.width = size.width
        self.height = size.height
    }
}
