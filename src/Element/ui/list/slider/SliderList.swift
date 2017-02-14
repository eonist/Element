import Cocoa
@testable import Utils
/**
 * NOTE: the slider keeps track of the progress
 * TODO: you may need to add an update method like SliderTreeList has, imagine if your scrolled to the bottom nd then an item is removed what happens? you should update the slider and y.position of the itemsContainer
 * TODO: Do more research into the scroller speed. as its now an  arbetrary value of 30. Do you pull this from the user profile or?
 */
class SliderList:List,ISliderList{
    var slider:VSlider?
    var sliderInterval:CGFloat?
    override func resolveSkin() {
        super.resolveSkin()
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)//<--TODO: Rather set the thumbHeight on init?
        //ElementModifier.hide(slider!, ListParser.itemsHeight(self) > slider!.height)/*<--new adition*/
    }
    override func scrollWheel(with event: NSEvent) {//swift 3 update
        scroll(event)/*forward the event to the extension*/
        Swift.print("firstVisibleItem: " + "\(firstVisibleItem)")
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
    func setProgress(_ progress:CGFloat){
        let progressValue = self.itemsHeight < height ? 0 : progress
        //Swift.print("progressValue: " + "\(progressValue)")
        ListModifier.scrollTo(self,progressValue)/*Sets the target item to correct y, according to the current scrollBar progress*/
    }
    func onSliderChange(_ sliderEvent:SliderEvent){/*Handler for the SliderEvent.change*/
        setProgress(sliderEvent.progress)
    }
    /**
     * TODO: Add hide slider asssert here see SliderList for implementation
     */
    override func onDataProviderEvent(_ event: DataProviderEvent) {
        super.onDataProviderEvent(event)
        Swift.print("event.startIndex: " + "\(event.startIndex)")
        Swift.print("firstVisibleItem: " + "\(firstVisibleItem)")
        if(event.type == DataProviderEvent.remove){
            if(event.startIndex < firstVisibleItem){
                lableContainer!.y += itemHeight
                Swift.print("offset.y + 24")
            }
        }else if(event.type == DataProviderEvent.add){
            if(event.startIndex < firstVisibleItem){
                lableContainer!.y -= itemHeight
                Swift.print("offset.y - 24")
            }
        }
        
        if(dp.count <= numOfItemsCanFit){
            lableContainer!.y = 0
        }
        
        //When items are removed bellow lastVisibleItem -> offset needs to take effect. 
            //As we should never have a list that isnt pinned to the bottom
        
        /*Updates the slider interval and the sliderThumbSize*/
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
        slider!.setProgressValue(progress)
        
    }
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change, slider)){onSliderChange(event.cast())}/*events from the slider*/
        super.onEvent(event)
    }
    /**
     * TODO: must update the float somehow
     * Sets the list to correct height, the scrollbar thumb to correct size and the scrollbar interval to correct interval
     */
    override func setSize(_ width:CGFloat, _ height:CGFloat) {//TODO: when max showing is set to 3 and there are 4 items the sliderTHumbsize is wrong
        slider!.setSize(itemHeight, height)
        sliderInterval = floor(ListParser.itemsHeight(self) - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        super.setSize(width,height)
        ElementModifier.hide(slider!, itemsHeight > slider!.height)/*Hides the slider if it is not needed anymore*///<--new adition
    }
}

extension SliderList{
    /**
     *
     */
    var firstVisibleItem:Int{
        let a = abs(lableContainer!.y)//force positive value with abs
        let b = a/itemHeight//how many items fit into "a"
        let c = floor(b)//Continue here
        let firstVisibleItem:Int = c.int
        Swift.print("firstVisibleItem: " + "\(firstVisibleItem)")
        return firstVisibleItem
    }
    var numOfItemsCanFit:Int {
        return floor(height/itemHeight).int
    }
}
