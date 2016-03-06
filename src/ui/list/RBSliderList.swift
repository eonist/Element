import Cocoa
/**
 * TODO: Add support fo rubberband behaviour even if there is no need for scrolling
 * TODO: make the top and bottom values when scrolling absolutly pinned to 0 and 1. There should be a final tick that cooresponds to these values in the Mover class
 */
class RBSliderList:List {
    var scrollController:RBScrollController?
    var slider:VSlider?
    private var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        scrollController = RBScrollController(self,CGRect(0,0,width,height),CGRect(0,0,width,ListParser.itemsHeight(self)))
        /*slider*/
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self)) as? VSlider
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
    }
    func setProgress(value:CGFloat){
        lableContainer!.frame.y = value
        let scalar:CGFloat = value / -(ListParser.itemsHeight(self) - height)/*get the the scalar values from value.*/
        //Swift.print("scalar: " + "\(scalar)")
        // Swift.print("setProgressValue.start")
        slider?.setProgressValue(scalar)
        //Swift.print("setProgressValue.end")
    }
    override func scrollWheel(theEvent:NSEvent) {
        scrollController?.scrollWheel(theEvent)//forward the event
        if(theEvent.phase == NSEventPhase.Changed){setProgress(scrollController!.mover.result)}/*direct manipulation*/
    }
    override func onFrame(){
        if(scrollController!.mover.hasStopped){//stop the frameTicker here
            CVDisplayLinkStop(displayLink)
        }else{//only move the view if the mover is not stopped
            scrollController!.mover.updatePosition()/*tick the mover*/
            setProgress(scrollController!.mover.result)/*indirect manipulation aka momentum*/
        }
        super.onFrame()
    }
}