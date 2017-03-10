import Foundation
@testable import Utils

class ElasticUtils {
    /**
     * Used when applying progress to the Slider thumb. When scrolling with elastisity
     * NOTE: The problem is that when the left over is small the overshoot gets huge.
     */
    static func progress(_ value:CGFloat, _ itemsHeight:CGFloat, _ height:CGFloat)->CGFloat{
        var progress:CGFloat = value / -(itemsHeight - height)
        if(progress < 0){
            let overshot = (value/height)
            progress = progress.clip(0,1) - overshot
        }else if(progress > 1){
            let overshot = ((-value-(itemsHeight-height))/height)
            //Swift.print("overshot: " + "\(overshot)")//(value-leftover)/height
            progress = progress.clip(0,1) + overshot
        }
        return progress
    }
}
