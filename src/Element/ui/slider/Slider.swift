import Foundation
@testable import Utils
@testable import Element

class Slider:Element{
    var thumb:Thumb?
    var progress:CGFloat
    var thumbSize:CGSize
    var dir:Dir
    init(_ width:CGFloat, _ height:CGFloat,_ dir:Dir = .ver,  _ progress:CGFloat = 0, _ thumbSize:CGSize? = nil, _ parent:IElement? = nil, id:String? = nil){
        self.progress = progress
        self.thumbSize = thumbSize ?? (dir == .ver ? CGSize(width,width) : CGSize(height,height))
        self.dir = dir
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        //skin.isInteractive = false// :TODO: explain why in a comment
        //skin.useHandCursor = false;// :TODO: explain why in a comment
        thumb = addSubView(Thumb(thumbSize.width, thumbSize.height,false,self))
        setProgressValue(progress)// :TODO: explain why in a comment, because initially the thumb may be positioned wrongly  due to clear and float being none
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension Slider{
    /**
     * PARAM: progress (0-1)
     */
    func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
        self.progress = progress.clip(0,1)/*if the progress is more than 0 and less than 1 use progress, else use 0 if progress is less than 0 and 1 if its more than 1*/
        thumb!.point[dir] = Utils.thumbPosition(self.progress, frame.size[dir], thumbSize[dir])
        thumb!.applyOvershot(progress)/*<--we use the unclipped scalar value*/
    }
}
private class Utils{//TODO:rename to VSliderUtils and make it not private
    /**
     * Returns the position of a thumbs PARAM progress
     */
    class func thumbPosition(_ progress:CGFloat, _ side:CGFloat, _ thumbSide:CGFloat)->CGFloat {
        let minThumbPos:CGFloat = side - thumbSide/*Minimum thumb position*/
        return progress * minThumbPos
    }
}
