import Foundation
@testable import Utils
@testable import Element

class Slider:Element{
    var progress:CGFloat = 0
    init(_ width:CGFloat, _ height:CGFloat,_ thumbHeight:CGFloat = NaN, _ progress:CGFloat = 0,_ parent:IElement? = nil, id:String? = nil){
        self.progress = progress
        self.thumbHeight = thumbHeight.isNaN ? width:thumbHeight// :TODO: explain in a comment what this does
        super.init(width,height,parent,id)
    }
}
extension Slider{
    func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
        //
    }
}
