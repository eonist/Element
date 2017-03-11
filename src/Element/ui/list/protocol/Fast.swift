import Foundation

protocol Fast{}

//Continue here: 🏀
    //move the FastListSetProgress into the fast protocol!

extension Fast{
    
    /**
     * PARAM: progress (0-1)
     * NOTE: setProgress is in this class because RBFastSliderList doesn't extend SliderList, and both classes needs to extend this method
     * NOTE: override this method in SliderFastList and RBSliderFastList
     *
     * The concept is simple, you only show items that are within the limits as you scroll up and down. (these items only exists virtually, untill they are revealed if they are within the limits)
     * With these two rules: you should be able to create the algorithm that lay out items at a progress value
     * Stage.1: Remove items outside Limits
     * Stage.2: stack items to cover the visible area
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("🐎 FastList2.setProgress() ")
        //ScrollableUtils.scrollTo(self, progress)/*moves the labelContainer up and down*/
        super.setProgress(progress)//moves lableContainer
        let range:Range<Int> = visibleItemRange.start..<Swift.min(visibleItemRange.end,dp.count)
        if(currentVisibleItemRange != range){/*Optimization: only set if it's not the same as prev range*/
            renderItems(range)
        }
    }
}
