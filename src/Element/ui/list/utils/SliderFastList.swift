import Cocoa
@testable import Utils
/**
 * TODO: Implement setSize, see SliderList for implementation
 */
class SliderFastList: DEPRECATED_FastList, DEPRECATED_ISliderList {
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
    override func scrollWheel(with event:NSEvent) {
        scroll(event)/*forwards the event to the extension method*/
        super.scrollWheel(with:event)/*forwards the event other delegates higher up in the stack*/
    }
    override func setProgress(_ value:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : value//dont scroll if not needed
        //Swift.print("progressValue: " + "\(progressValue)")
        super.setProgress(progressValue)
    }
    /**
     * Captures SliderEvent.change and then adjusts the List accordingly
     */
    func onSliderChange(_ sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        //Swift.print("SliderFastList4.onSliderChange")
        setProgress(sliderEvent.progress)
        //ListModifier.scrollTo(self,sliderEvent.progress)
    }
    override func onDataProviderEvent(_ event: DataProviderEvent) {
        fatalError("⚠️️ DEPRECATED")
        /*super.onDataProviderEvent(event)
         //if(event.type == DataProviderEvent.add){}
         
         /*Updates the slider interval and the sliderThumbSize*/
         sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight
         let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
         slider!.setThumbHeightValue(thumbHeight)
         let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
         slider!.setProgressValue(progress)*/
        
        //TODO: Add hide slider asssert here see SliderList for implementation
    }
    override func onEvent(_ event:Event) {
        //Swift.print("SliderFastList4.onEvent: " + "\(event.type)")
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        else {super.onEvent(event)}
    }
    /**
     * TODO: This must be implemented in the future, see SliderList for instructions
     */
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        super.setSize(width, height)
    }
}
private class Utils{
    /**
     * TODO: use SliderParser.interval instead?// :TODO: explain what this is in a comment
     */
    static func sliderInterval(_ itemsHeight:CGFloat, _ height:CGFloat,_ itemHeight:CGFloat)->CGFloat{
        return floor(itemsHeight - height)/itemHeight
    }
    /**
     * TODO: use SliderParser.thumbHeight instead
     */
    static func thumbHeight(_ height:CGFloat,_ itemsHeight:CGFloat,_ sliderHeight:CGFloat)->CGFloat{
        return SliderParser.thumbSize(height/itemsHeight, sliderHeight)
    }
}
