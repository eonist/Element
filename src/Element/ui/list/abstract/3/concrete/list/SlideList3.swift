import Cocoa
@testable import Utils
@testable import Element

class SlideList3:List3,Slidable3 {
    lazy var horSlider:Slider? = self.hSlider
    lazy var verSlider:Slider? = self.vSlider
    override func onEvent(_ event:Event) {
        if(event == SliderEvent.change){
            let dir:Dir = event.origin === horSlider ? .hor : .ver
            setProgress((event as! SliderEvent).progress,dir)
        }
        super.onEvent(event)
    }
}
extension Slidable3{
    var hSlider:Slider {
        let horSlider:Slider = (self as! NSView).addSubView(Slider(self.width,self.itemSize.height,.hor,self.itemSize,0,(self as! IElement)))
        let thumbWidth:CGFloat = SliderParser.thumbSize(width/itemSize.width, horSlider.width)
        horSlider.setThumbSide(thumbWidth)
        horSlider.thumb!.fadeOut()//inits fade out anim on init
        return horSlider
    }
    var vSlider:Slider{
        let verSlider:Slider = (self as! NSView).addSubView(Slider(self.itemSize.width,self.height,.ver,self.itemSize,0,(self as! IElement)))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/contentSize.height, verSlider.height)
        verSlider.setThumbSide(thumbHeight)
        verSlider.thumb!.fadeOut()//inits fade out anim on init
        return verSlider
    }
}
/*extension SlideList3{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("SlideView3.scrollWheel() \(event.type)")
        super.scrollWheel(with: event)
        if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        /*else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
         //hideSlider()
         }*/
    }
}*/
