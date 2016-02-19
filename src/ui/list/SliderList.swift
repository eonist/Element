import Cocoa

class SliderList : List{
    private var slider:VSlider?
    private var sliderInterval:CGFloat?
    
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight;// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self)) as? VSlider
        var thumbHeight:CGFloat = SliderParser.thumbSize(height/getItemsHeight(), slider.height);
        //slider.setThumbHeight(thumbHeight);
        //ElementModifier.hide(slider, getItemsHeight() > slider.height)/*<--new adition*/
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
        super.scrollWheel(theEvent)
    }
}
