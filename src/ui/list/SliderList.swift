import Cocoa
/**
 * // :TODO: you may need to add an update method like SliderTreeList has, imagine if your scrolled to the bottom nd then an item is removed what happens? you should update the slider and y.position of the itemsContainer
 */
class SliderList : List{
    private var slider:VSlider?
    private var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self)) as? VSlider
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        //ElementModifier.hide(slider!, ListParser.itemsHeight(self) > slider!.height)/*<--new adition*/
    }
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
        let scrollAmount:CGFloat = (theEvent.deltaY/100)/sliderInterval!/*_scrollBar.interval*/
        var currentScroll:CGFloat = slider!.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)
        ListModifier.scrollTo(self,currentScroll) /*Sets the target item to correct y, according to the current scrollBar progress*/
        slider?.setProgressValue(currentScroll)
        super.scrollWheel(theEvent)
    }
    func onSliderChange(sliderEvent:SliderEvent){
        ListModifier.scrollTo(self,sliderEvent.progress)
    }
    override func onEvent(event: Event) {
        if(event.type == SliderEvent.change && event.origin === slider){onSliderChange(event as! SliderEvent)}
    }
    /**
     * // :TODO: must update the float somehow
     * Sets the list to correct height, the scrollbar thumb to correct size and the scrollbar interval to correct interval
     */
    override func setSize(width:CGFloat, _ height:CGFloat) {// :TODO: when max showing is set to 3 and there are 4 items the sliderTHumbsize is wrong
        slider!.setSize(itemHeight, height)
        _sliderInterval = Math.floor(getItemsHeight() - height)/itemHeight;
        var thumbHeight:Number = SliderParser.thumbSize(height/getItemsHeight(), _slider.height/*<--this should probably be .getHeight()*/);
        _slider.setThumbHeight(thumbHeight);
        super.setSize(width,height);
        ElementModifier.hide(_slider, getItemsHeight() > _slider.height);/*<--new adition*/
    }
}
