/**
 * 13.05.21 15:00 - Added support for mousewheel, and replaced scrollbars with sliders
 * @Note it seems difficult to align the HSlider thumb in a relative but correct way, since offsetting the HSlider it self is difficult when thumb is positioned by absolute values
 * // :TODO: could possible use a setHtmlText function??!?
 * // :TODO: you may need to access gestures to get hold of horzontal mouse delta, when you want to use gestures to scroll horizontally
 * // :TODO: the horizontal scroller isnt thourghouly testes. Make sure you set wordwrap to false to test this, and that the input text has break tags \n or br tags
 * // :TODO: Impliment a failsafe so that the slider.thumb doesnt get smaller than its width, do the same for both sliders
 */
class SliderTextArea{
	 private static const linesPerScroll:Number = 1/*The number of lines the scroller scrolls at every scroll up or down*/// :TODO: this cant be set higher unless you add code to the eventhandlers that allow it
	 private var _scrollBarSize:Number
	 private var _vSlider:VSlider
	 private var _hSlider:HSlider
	 private var _vSliderInterval:Int
	 private var _hInterval:Int
	 
	init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ scrollBarSize:CGFloat = 24, _ parent:IElement? = nil, _ id:String? = nil){
		
	}		
}