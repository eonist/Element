import Cocoa
@testable import Utils
/**
 * NOTE: the slider keeps track of the progress
 * TODO: you may need to add an update method like SliderTreeList has, imagine if your scrolled to the bottom nd then an item is removed what happens? you should update the slider and y.position of the itemsContainer
 * TODO: Do more research into the scroller speed. as its now an  arbetrary value of 30. Do you pull this from the user profile or?
 */
class SliderList:List,ISliderList{
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)//<--TODO: Rather set the thumbHeight on init?
        //ElementModifier.hide(slider!, ListParser.itemsHeight(self) > slider!.height)/*<--new adition*/
    }
    override func scrollWheel(with event: NSEvent) {//swift 3 update
        scroll(event)/*forward the event to the extension*/
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
    func setProgress(_ progress:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : progress
        //Swift.print("progressValue: " + "\(progressValue)")
        ListModifier.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
    func onSliderChange(_ sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        setProgress(sliderEvent.progress)
    }
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * TODO: must update the float somehow
     * Sets the list to correct height, the scrollbar thumb to correct size and the scrollbar interval to correct interval
     */
    override func setSize(_ width:CGFloat, _ height:CGFloat) {//TODO: when max showing is set to 3 and there are 4 items the sliderTHumbsize is wrong
        slider!.setSize(itemHeight, height)
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        super.setSize(width,height)
        ElementModifier.hide(slider!, itemsHeight > slider!.height)/*Hides the slider if it is not needed anymore*///<--new adition
    }
}
