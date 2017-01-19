import Cocoa
@testable import Utils

class SliderFastList:FastList,ISliderList {
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use SliderParser.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/ListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)//<--TODO: Rather set the thumbHeight on init?
    }
    override func scrollWheel(with event:NSEvent) {
        scroll(event)/*Forwards the event to the extension method*/
        super.scrollWheel(with:event)/*Forwards the event other delegates higher up in the stack*/
    }
    func onSliderChange(_ sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        ListModifier.scrollTo(self,sliderEvent.progress)
    }
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * TODO: This must be implemented in the future, see SliderList for instructions
     */
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
    }
}
