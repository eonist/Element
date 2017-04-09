import Foundation
@testable import Utils
@testable import Element

class Slider:Element{
    var progress:CGFloat
    var thumbSize:CGSize
    init(_ width:CGFloat, _ height:CGFloat,_ thumbSize:CGSize, _ progress:CGFloat = 0,_ parent:IElement? = nil, id:String? = nil){
        self.progress = progress
        self.thumbSize = thumbSize
        super.init(width,height,parent,id)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension Slider{
    func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
        self.progress = progress
    }
}
