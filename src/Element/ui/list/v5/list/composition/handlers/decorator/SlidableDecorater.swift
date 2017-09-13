import Foundation
@testable import Utils
//rename to ....Accessor
protocol SlidableDecorater:ProgressableDecorator,Slidable5 {}

extension SlidableDecorater{
    var vSlider:Slider {get{return slidable.vSlider}}
    var hSlider:Slider {get{return slidable.hSlider}}
    var slidable:Slidable5 {return progressable as! Slidable5}
    
    /*NOTE: If you need only one slider, then override both hor and ver with this slider*/
    func slider(_ dir:Dir) -> Slider { return dir == .ver ? vSlider : hSlider}/*Convenience*/
}
