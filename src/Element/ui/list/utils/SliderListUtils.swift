import Foundation
@testable import Utils

class SliderListUtils{//⚠️️ This can probably be removed, as the same code is in SliderParser or alike, at least move to SliderParser
    /**
     * Returns the progress og the sliderList (used when we scroll with the scrollwheel/touchpad) (0-1)
     */
    static func progress(_ delta:CGFloat,_ sliderInterval:CGFloat,_ sliderProgress:CGFloat)->CGFloat{
        let scrollAmount:CGFloat = (delta/30)/sliderInterval/*_scrollBar.interval*/
        var currentScroll:CGFloat = sliderProgress - scrollAmount/*The minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = currentScroll.clip(0, 1)/*Clamps the num between 0 and 1*/
        return currentScroll
    }
}
extension SliderListUtils{
    
}
