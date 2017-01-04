import Cocoa

class SliderFastList2:FastList2,ISliderList {
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use SliderParser.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)//<--TODO: Rather set the thumbHeight on init?
    }
    /**
     * Captures the Native scrollWheel event, and relays the event to the extension method 'scroll' 
     */
    override func scrollWheel(event:NSEvent) {
        scroll(event)/*forwards the event to the extension method*/
        super.scrollWheel(event)/*forwards the event other delegates higher up in the stack*/
    }
    /**
     * Captures SliderEvent.change and then adjusts the List accordingly
     */
    func onSliderChange(sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        setProgress(sliderEvent.progress)
        //ListModifier.scrollTo(self,sliderEvent.progress)
    }
    override func onDataProviderEvent(event: DataProviderEvent) {
        super.onDataProviderEvent(event)
        //
        sliderInterval = floor(itemsHeight - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
    }
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        else {super.onEvent(event)}//forward dataProviderEvents etc, but not SliderEvents as they fire too rapidly
    }
}