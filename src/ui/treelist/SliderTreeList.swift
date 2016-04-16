import Foundation
/**
 * @Note you must supply the itemHeight, since we need it to calculate the interval
 */
class SliderTreeList:TreeList{
    var sliderInterval:CGFloat?
    var slider:VSlider?
    override func resolveSkin() {
        super.resolveSkin()
        var itemsHeight:CGFloat = TreeListParser.itemsHeight(self)
        sliderInterval = SliderParser.interval(itemsHeight, getHeight(), itemHeight)//Math.floor(itemsHeight - getHeight())/itemHeight;// :TODO: use ScrollBarUtils.interval instead?
        slider = addChild(new VSlider(itemHeight,getHeight(),itemHeight,0,this)) as VSlider
        var thumbHeight:CGFloat = SliderParser.thumbSize(getHeight()/itemsHeight, slider.getHeight())
        slider!.setThumbHeightValue(thumbHeight)
        //slider!.hidden = !SliderParser.assertSliderVisibility(thumbHeight/slider!.getHeight())
    }
}
