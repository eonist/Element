import Cocoa
@testable import Utils
/**
 * NOTE: You must supply the itemHeight, since we need it to calculate the interval
 */
class SliderTreeList:TreeList{
    var sliderInterval:CGFloat?
    var slider:VSlider?
    override func resolveSkin() {
        super.resolveSkin()
        let itemsHeight:CGFloat = TreeListParser.itemsHeight(self)
        sliderInterval = SliderParser.interval(itemsHeight, getHeight(), itemHeight)//Math.floor(itemsHeight - getHeight())/itemHeight;// :TODO: use ScrollBarUtils.interval instead?
        slider = addSubView(VSlider(NaN,getHeight(),0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/TreeListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        
        //slider!.hidden = !SliderParser.assertSliderVisibility(thumbHeight/slider!.getHeight())
    }
    /**
     * Updates the thumb position and the position of the itemsContainer
     */
    func update(){
        Swift.print("SliderTreeList.update()");
        let itemsHeight:CGFloat = TreeListParser.itemsHeight(self)/*total height of the items*/
        /*
        Swift.print("itemsHeight: " + itemsHeight)
        Swift.print("itemHeight: " + itemHeight)
        Swift.print("getHeight(): " +  getHeight())
        */
        sliderInterval = SliderParser.interval(itemsHeight, getHeight(), itemHeight)
        //Swift.print("update() _sliderInterval: " + _sliderInterval);
        let thumbHeight:CGFloat = SliderParser.thumbSize(getHeight()/itemsHeight, slider!.getHeight())
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(itemContainer!.y, getHeight(), itemsHeight)
        slider!.setProgressValue(progress)
        //slider.hidden = !SliderParser.assertSliderVisibility(_slider.thumb.getHeight()/slider.getHeight())
        TreeListModifier.scrollTo(self, progress)
    }
    func onSliderChange(_ sliderEvent:SliderEvent){
        TreeListModifier.scrollTo(self,sliderEvent.progress)
    }
    func onTreeListChange(_ event:TreeListEvent) {
        Swift.print("SliderTreeList.onTreeListChange - _sliderInterval:" + "\(sliderInterval)")
        update()
    }
    override func scrollWheel(with event: NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        let scrollAmount:CGFloat = (event.deltaY/30)/sliderInterval!/*_scrollBar.interval*/
        var currentScroll:CGFloat = slider!.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)
        //Swift.print("currentScroll: " + "\(currentScroll)")
        TreeListModifier.scrollTo(self,currentScroll)  /*Sets the target item to correct y, according to the current scrollBar progress*/
        slider?.setProgressValue(currentScroll)
        if(event.momentumPhase == NSEventPhase.ended){
            Swift.print("the scroll motion ended")
            slider!.thumb!.setSkinState("inActive")
        }else if(event.momentumPhase == NSEventPhase.began){//include maybegin here
            Swift.print("the scroll motion began")
            slider!.thumb!.setSkinState(SkinStates.none)
        }
        super.scrollWheel(with:event)
    }
    override func onEvent(_ event: Event) {
        if(event.type == SliderEvent.change && event.origin === slider){onSliderChange(event.cast())}
        if(event.type == TreeListEvent.change){onTreeListChange(event.cast())}
        super.onEvent(event)//<--We need to forward the events to TreeList, or else TreeList will not work correctly
    }
}
