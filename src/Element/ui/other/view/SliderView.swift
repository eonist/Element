import Foundation
@testable import Utils

class SliderView:ScrollView,ISlidable {
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        /*slider*/
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
    }
    override func onEvent(_ event:Event) {
        if(event == SliderEvent.change){onSliderChange(event.cast())}/*events from the slider*/
        super.onEvent(event)
    }
}
