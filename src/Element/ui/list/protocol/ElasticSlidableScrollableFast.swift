import Foundation
@testable import Utils

protocol ElasticSlidableScrollableFast:IFastList2,ElasticSlidableScrollable {

}
extension ElasticSlidableScrollableFast{
    /**
     * PARAM value: is the final y value for the lableContainer
     */
    override func setProgress(_ value:CGFloat){
        //Swift.print("value: " + "\(value)")
        let itemsHeight = self.itemsHeight//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if(itemsHeight < height){//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / height
            //Swift.print("progressValue: " + "\(progressValue)")
            let y = progressValue! * height
            //Swift.print("y: " + "\(y)")
            rbContainer!.y = y
        }else{
            progressValue = value /  -(itemsHeight - height)/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            super.setProgress(progress)/*moves the lableContainer up and down*/
            slider!.setProgressValue(progressValue!)
            /*finds the values that is outside 0 and 1*/
            //Swift.print("progressValue!: " + "\(progressValue!)")
            if(progressValue! < 0){
                let y1 = itemsHeight * -progressValue!
                //Swift.print("y1: " + "\(y1)")
                rbContainer!.y = y1/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if(progressValue! > 1){
                let y2 = itemsHeight * -(progressValue!-1)
                //Swift.print("y2: " + "\(y2)")
                rbContainer!.y = y2
            }else{
                rbContainer!.y = 0/*default position*/
            }
        }
    }
}
