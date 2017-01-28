import Foundation

class SwitchSlider:Element {
    var progress:CGFloat
    init(_ width:CGFloat, _ height:CGFloat, _ progress:CGFloat = 0, _ parent:IElement? = nil, _ id:String? = nil, _ classId:String? = nil) {
        self.progress = progress
        super.init(width,height,parent,id)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
