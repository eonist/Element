import Cocoa

class SliderFastList3:FastList3,ISliderList {
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = Utils.sliderInterval(itemsHeight, height, itemHeight)
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = Utils.thumbHeight(height, itemsHeight, slider!.height)/*<--This should probably be .getHeight()*/
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
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        else {super.onEvent(event)}//forward dataProviderEvents etc, but not SliderEvents as they fire too rapidly
    }
}
private class Utils{
    /**
     * // :TODO: use SliderParser.interval instead?// :TODO: explain what this is in a comment
     */
    static func sliderInterval(itemsHeight:CGFloat, _ height:CGFloat,_ itemHeight:CGFloat)->CGFloat{
        return floor(itemsHeight - height)/itemHeight
    }
    /**
     * TODO: use SliderParser.thumbHeight instead
     */
    static func thumbHeight(height:CGFloat,_ itemsHeight:CGFloat,_ sliderHeight:CGFloat)->CGFloat{
        return SliderParser.thumbSize(height/itemsHeight, sliderHeight)
    }
}