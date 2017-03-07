import Cocoa
@testable import Utils

//fix the progressindicator, its not showing anymore
//add RBSliderView to Prefs

class SliderView:ScrollView,ISlidable {
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        /*slider*/
        //Swift.print("SliderView.height: " + "\(height)")
        //Swift.print("SliderView.getHeight(): " + "\(getHeight())")
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        slider!.thumb!.fadeOut()//inits fade out anim on init
    }
    override func onEvent(_ event:Event) {
        //Swift.print("event: " + "\(event)")
        if(event === (SliderEvent.change,slider!)){
            setProgress((event as! SliderEvent).progress)
        }/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * When the the user scrolls
     */
    override func scrollWheel(with event: NSEvent) {//swift 3 update
        scroll(event)/*forward the event to the extension which adjust Slider and calls setProgress in this method*/
        //IMPORTANT: for now let's not pass on the scrollWheel.if this backfires, aka wee need scroolwheel for NSView at another level, then make a scheme that calls the correct scroll, aka make scroll inheritable and overridable and then call doScroll with the extension method attached
        //super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
}
