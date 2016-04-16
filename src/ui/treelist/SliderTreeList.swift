import Foundation

class SliderTreeList:TreeList{
    override func resolveSkin() {
        super.resolveSkin()
        var itemsHeight:Number = TreeListParser.itemsHeight(this)
        _sliderInterval = SliderParser.interval(itemsHeight, getHeight(), itemHeight)//Math.floor(itemsHeight - getHeight())/itemHeight;// :TODO: use ScrollBarUtils.interval instead?
        _slider = addChild(new VSlider(itemHeight,getHeight(),itemHeight,0,this)) as VSlider
        var thumbHeight:Number = SliderParser.thumbSize(getHeight()/itemsHeight, _slider.getHeight())
        _slider.setThumbHeight(thumbHeight)
        _slider.visible = SliderParser.assertSliderVisibility(thumbHeight/_slider.getHeight())
    }
}
