import Foundation
@testable import Utils
@testable import Element

class Slider:Element{

}
extension Slider{
    
}
func setProgressValue(_ progress:CGFloat){/*Can't be named setProgress because of objc*/
    self.progress = progress.clip(0,1)/*If the progress is more than 0 and less than 1 use progress, else use 0 if progress is less than 0 and 1 if its more than 1*/
    thumb!.x = HSliderUtils.thumbPosition(self.progress, width, thumbWidth)
    //thumb?.applyOvershot(progress)/*<--We use the unclipped scalar value*/ //TODO:This should really be apart of the RBSlider system
}
