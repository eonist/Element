import Cocoa
@testable import Utils
/**
 * TODO: You need to update slider and mover on DP event: see SliderList for implementation
 */

//Continue here: 
    //make RBScrollView, no need to have duplicate code everywhere, 
    //essentially i think you may be able to add it to rbsliderfastlist and rbsliderlist etc. 
    //also SliderList etc can have SlideView etc.
    //it will simplify refactorings etc. 

class RBSliderFastList:FastList, IRBScrollableSlidable {
    /*RubberBand*/
    var mover:RubberBand?
    var prevScrollingDeltaY:CGFloat = 0/*this is needed in order to figure out which direction the scrollWheel is going in*/
    var velocities:[CGFloat] = Array(repeating: 0, count: 10)/*represents the velocity resolution of the gesture movment*/
    var progressValue:CGFloat?//<--same as progress but unclamped (because RBSliderList may go beyond 0 to 1 values etc)
    /*Slider*/
    var slider:VSlider?
    var sliderInterval:CGFloat?
    var rbContainer:Container?/*needed for the overshot animation*/
    override func resolveSkin() {
        super.resolveSkin()
        rbContainer = addSubView(Container(width,height,self,"rb"))
        rbContainer!.addSubview(lableContainer!)//add lable Container inside rbContainer
        lableContainer!.parent = rbContainer!
        /*RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be renamed to maskRect
        let itemsRect = CGRect(0,0,width,max(itemsHeight,height))/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, avoids logging missing eventHandler, this has no functionality in this class, but may have in classes that extends this class*/
        
        //TODO:It could be possible to just call updateSlider() instead of the bellow calculations
        
        /*slider*/
        sliderInterval = floor(itemsHeight - height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(VSlider(itemHeight,height,0,0,self))/*add vSlider to view*/
        if(itemsHeight <= height){slider!.thumb!.setDisabled(true);slider!.thumb!.alpha = 0}/*if there is no need for the slider, then hide it*/
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)/*Calc the thumbHeight*/
        slider!.setThumbHeightValue(thumbHeight)/*set the init thumbHeight*/
        setProgress(0)/*<--Not really needed, but nice to have while debugging*/
    }
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
    /**
     * NOTE: this method overides the Native NSView scrollWheel method
     */
    override func scrollWheel(with event:NSEvent) {
        scroll(event)/*forward the event to the scrollExtension*/
        if(event.phase == NSEventPhase.changed){setProgress(mover!.result)}/*direct manipulation*/
        super.scrollWheel(with:event)/*keep forwarding the scrollWheel event for NSViews higher up the hierarcy to listen to*/
    }
    /**
     * TODO: Add hide slider asssert here see SliderList for implementation
     */
    override func onDataProviderEvent(_ event:DataProviderEvent) {
        super.onDataProviderEvent(event)
        /*Update RubberBand*/
        let frame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be renamed to maskRect
        let itemsRect = CGRect(0,0,width,max(itemsHeight,height))/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover!.frame = frame
        mover!.itemsRect = itemsRect
        /*Update the slider*/
        updateSlider()
    }
    override func onEvent(_ event:Event) {
        //Swift.print("RBSliderFastList4.onEvent even.type: \(event.type)" )
        if(event.assert(SliderEvent.change,slider)){
            onSliderChange(event.cast())
        }else if(event.assert(AnimEvent.stopped, mover!)){
            scrollAnimStopped()
        }
        super.onEvent(event)
    }
}
extension RBSliderFastList{//TODO:rather extend IRBSliderFastList
    /**
     * EventHandler for the Slider change event
     */
    func onSliderChange(_ sliderEvent:SliderEvent){
        ScrollableUtils.scrollTo(self, sliderEvent.progress)
        mover!.value = lableContainer!.frame.y
    }
}
