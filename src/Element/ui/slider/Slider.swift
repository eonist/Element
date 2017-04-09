import Foundation
@testable import Utils
@testable import Element

class Slider:Element{
    var thumb:Thumb?
    var progress:CGFloat
    var thumbSize:CGSize
    init(_ width:CGFloat, _ height:CGFloat,_ thumbSize:CGSize, _ progress:CGFloat = 0,_ parent:IElement? = nil, id:String? = nil){
        self.progress = progress
        self.thumbSize = thumbSize
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        //skin.isInteractive = false// :TODO: explain why in a comment
        //skin.useHandCursor = false;// :TODO: explain why in a comment
        thumb = addSubView(Thumb(width, thumbHeight,false,self))
        setProgressValue(progress)// :TODO: explain why in a comment, because initially the thumb may be positioned wrongly  due to clear and float being none
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension Slider{
    func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
        self.progress = progress
    }
}
