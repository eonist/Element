import Foundation

protocol Displacable2:class {
    var height:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemHeight:CGFloat{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    //var progress:CGFloat {get}//<--⚠️️try to remove this⚠️️
    var lableContainer:Element? {get}
}
extension Displacable2{
    /**
     * ⚠️️ You might want to have one setProgress in scroll and one in slider and use protocol ambiguity to differentiate, but then you cant have this method in base like it is now
     * PARAM value: is the final y value for the lableContainer
     * Moves the itemContainer.y up and down
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ progress:CGFloat){
        print("🖼️ moving lableContainer up and down progress: \(progress)")
        //Swift.print("IScrollable.setProgress() progress: \(progress)")
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        ScrollableUtils.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
}
