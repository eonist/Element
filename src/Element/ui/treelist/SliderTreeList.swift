import Cocoa
@testable import Utils
/**
 * NOTE: You must supply the itemHeight, since we need it to calculate the interval
 */
class SliderTreeList:TreeList,ISliderTreeList{
    
    var sliderInterval:CGFloat?
    var slider:VSlider?
    override func resolveSkin() {
        super.resolveSkin()
        let itemsHeight:CGFloat = TreeListParser.itemsHeight(self)
        sliderInterval = SliderParser.interval(itemsHeight, getHeight(), itemHeight)//Math.floor(itemsHeight - getHeight())/itemHeight;// :TODO: use ScrollBarUtils.interval instead?
        slider = addSubView(VSlider(NaN,getHeight(),0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/TreeListParser.itemsHeight(self), slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        let hide:Bool = itemsHeight < height
        Swift.print("hide: " + "\(hide)")
        ElementModifier.hide(slider!, itemsHeight < height)/*<--new adition*/
        slider!.isHidden = !SliderParser.assertSliderVisibility(thumbHeight/slider!.getHeight())
    }
    /**
     * Updates the thumb position and the position of the itemsContainer
     */
    /*
    func update(){
        Swift.print("SliderTreeList.update()");
        
        /*
        Swift.print("itemsHeight: " + itemsHeight)
        Swift.print("itemHeight: " + itemHeight)
        Swift.print("getHeight(): " +  getHeight())
        */
        sliderInterval = floor(itemsHeight - height)/itemHeight//2SliderParser.interval(itemsHeight, getHeight(), itemHeight)
        //Swift.print("update() _sliderInterval: " + _sliderInterval);
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.getHeight())
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(itemContainer!.y, height, itemsHeight)
        let progressValue = itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        slider!.setProgressValue(progressValue)
        //slider.hidden = !SliderParser.assertSliderVisibility(_slider.thumb.getHeight()/slider.getHeight())
        
    }
    */
    /**
     * Moves the itemContainer up and down
     */
    func setProgress(_ progress: CGFloat) {
        let progressValue = itemsHeight < height ? 0 : progress
        TreeListModifier.scrollTo(self, progressValue)/*moves the labelContainer up and down*/
    }
    /**
     * Captures SliderEvent.change and then adjusts the List accordingly
     */
    func onSliderChange(_ sliderEvent:SliderEvent){
        setProgress(sliderEvent.progress)//TreeListModifier.scrollTo(self,sliderEvent.progress)
    }
    /**
     * TreeListEvent's happen when the TreeList has changed, aka items are added/removed/edited
     */
    func onTreeListChange(_ event:TreeListEvent) {
        Swift.print("SliderTreeList.onTreeListChange - _sliderInterval:" + "\(sliderInterval)")
        
        /*test solution - begins*/
        let progress:CGFloat = SliderParser.progress(itemContainer!.y, height, itemsHeight)
        let progressValue = itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        setProgress(progressValue)
        /*test solution - ends*/
        
        updateSlider()
        ElementModifier.hide(slider!, itemsHeight < height)/*<--new adition*/
    }
    override func scrollWheel(with event: NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        scroll(event)/*forward the event to the extension*/
        
        /*
        let scrollAmount:CGFloat = (event.deltaY/30)/sliderInterval!/*_scrollBar.interval*/
        var currentScroll:CGFloat = slider!.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1)
        //Swift.print("currentScroll: " + "\(currentScroll)")
        TreeListModifier.scrollTo(self,currentScroll)  /*Sets the target item to correct y, according to the current scrollBar progress*/
        slider?.setProgressValue(currentScroll)
        if(event.momentumPhase == NSEventPhase.ended){
            Swift.print("the scroll motion ended")
            slider!.thumb!.setSkinState("inActive")
        }else if(event.momentumPhase == NSEventPhase.began){//include maybegin here
            Swift.print("the scroll motion began")
            slider!.thumb!.setSkinState(SkinStates.none)
        }
        */
        
        super.scrollWheel(with:event)
    }
    override func onEvent(_ event: Event) {
        if(event.type == SliderEvent.change && event.origin === slider){onSliderChange(event.cast())}
        if(event.type == TreeListEvent.change){onTreeListChange(event.cast())}
        super.onEvent(event)//<--We need to forward the events to TreeList, or else TreeList will not work correctly
    }
}
protocol ISliderTreeList:ITreeList {
    var slider:VSlider?{get}
    var sliderInterval:CGFloat?{get set}
    func setProgress(_ progress:CGFloat)
}
extension ISliderTreeList{
    /**
     * NOTE: Slider list and SliderFastList uses this method
     */
    func scroll(_ theEvent:NSEvent) {
        let progress:CGFloat = SliderListUtils.progress(theEvent.deltaY, self.sliderInterval!, self.slider!.progress)
        //Swift.print("progress: " + "\(progress)")
        setProgress(progress)/*Sets the target item to correct y, according to the current scrollBar progress*/
        self.slider?.setProgressValue(progress)/*Positions the slider.thumb*/
        if(theEvent.momentumPhase == NSEventPhase.ended){self.slider!.thumb!.setSkinState("inActive")}
        else if(theEvent.momentumPhase == NSEventPhase.began){self.slider!.thumb!.setSkinState(SkinStates.none)}//include may begin here
    }
    /**
     * Updates the slider interval and the sliderThumbSize (after DP events: add/remove etc)
     */
    func updateSlider(){
        sliderInterval = floor(self.itemsHeight - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(itemContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
        slider!.setProgressValue(progress)
    }
}
