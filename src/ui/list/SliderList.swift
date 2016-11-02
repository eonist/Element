import Cocoa
/**
 * NOTE: the slider keeps track of the progress
 * TODO: you may need to add an update method like SliderTreeList has, imagine if your scrolled to the bottom nd then an item is removed what happens? you should update the slider and y.position of the itemsContainer
 * TODO: Do more research into the scroller speed. as its now an  arbetrary value of 30. Do you pull this from the user profile or?
 */
class SliderList:List{
    private var slider:VSlider?
    private var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        //ElementModifier.hide(slider!, ListParser.itemsHeight(self) > slider!.height)/*<--new adition*/
    }
    override func scrollWheel(theEvent:NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        let scrollAmount:CGFloat = (theEvent.deltaY/30)/sliderInterval!/*_scrollBar.interval*/
        var currentScroll:CGFloat = slider!.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)/*clamps the num between 0 and 1*/
        ListModifier.scrollTo(self,currentScroll) /*Sets the target item to correct y, according to the current scrollBar progress*/
        slider?.setProgressValue(currentScroll)
        if(theEvent.momentumPhase == NSEventPhase.Ended){
            Swift.print("the scroll motion ended")
            slider!.thumb!.setSkinState("inActive")
        }else if(theEvent.momentumPhase == NSEventPhase.Began){//include may begin here
            Swift.print("the scroll motion began")
            slider!.thumb!.setSkinState(SkinStates.none)
        }
        super.scrollWheel(theEvent)
    }
    func onSliderChange(sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        ListModifier.scrollTo(self,sliderEvent.progress)
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * // :TODO: must update the float somehow
     * Sets the list to correct height, the scrollbar thumb to correct size and the scrollbar interval to correct interval
     */
    override func setSize(width:CGFloat, _ height:CGFloat) {// :TODO: when max showing is set to 3 and there are 4 items the sliderTHumbsize is wrong
        slider!.setSize(itemHeight, height)
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        super.setSize(width,height)
        ElementModifier.hide(slider!, ListParser.itemsHeight(self) > slider!.height)/*<--new adition*/
    }
}