import Foundation

class SliderView:Element,ISlidable {
    var lableContainer:Container?
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    var itemsHeight:CGFloat = 600//override this
    var itemHeight:CGFloat = 24//override this
}
