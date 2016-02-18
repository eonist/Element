import Cocoa

class SliderList : List{
    private var _slider:VSlider;
    private var _sliderInterval:Number;
    
    
    
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
        super.scrollWheel(theEvent)
    }
}
