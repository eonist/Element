import Cocoa

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat = 600//override this
    var itemHeight:CGFloat = 24//override this
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
    }
}
extension ScrollView{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ progress:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        ScrollableUtils.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
}
