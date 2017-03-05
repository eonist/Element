import Cocoa

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat = 600//override this
    var itemHeight:CGFloat = 24//override this
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //lableContainer = addSubView(Container(width,height,self,"lable"))
    }
}
extension ScrollView{
    /**
     * PARAM value: is the final y value for the lableContainer
     * TODO: Try to use a preCalculated itemsHeight, as this can be heavy to calculate for lengthy lists
     */
    func setProgress(_ value:CGFloat){
        //Swift.print("RBSliderList.setProgress() value: " + "\(value)")
        lableContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        progressValue = value / -(itemsHeight - height)/*get the the scalar values from value.*/
        slider!.setProgressValue(progressValue!)
    }
}
