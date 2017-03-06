import Cocoa
@testable import Utils

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat = 600//override this for custom value
    var itemHeight:CGFloat = 24//override this for custom value
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
extension ScrollView{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ progress:CGFloat){
        Swift.print("ScrollView.setProgress() progress: \(progress)")
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        ScrollableUtils.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
}
