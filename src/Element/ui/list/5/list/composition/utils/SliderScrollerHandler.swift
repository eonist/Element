import Cocoa
@testable import Utils

/**
 * ⚠️️ IMPORTANT: Slidable does not override scroll because a SlideView can't detect scroll. SlideScrollView however can access scroll and call hide and show slider. And then use protocol ambiguity to call scroll on the Scrollable after
 */
class SliderScrollerHandler:ScrollHandler,Slidable5 {//Continue here: implements Slidable5 🏀
    var vSlider:Slider {get{return slidable.vSlider}}
    var hSlider:Slider {get{return slidable.hSlider}}
    var slidable:Slidable5 {return progressable as! Slidable5}
    
    /*NOTE: If you need only one slider, then override both hor and ver with this slider*/
    func slider(_ dir:Dir) -> Slider { return dir == .ver ? vSlider : hSlider}/*Convenience*/
    
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    override func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("SliderScrollerHandler.onScrollWheelChange")
        super.onScrollWheelChange(event)
        //Swift.print("🏂📜 SlidableScrollable3.onScrollWheelChange: \(event.type)")
        /*let horProg:CGFloat = SliderListUtils.progress(event.delta[.hor], interval(.hor), slider(.hor).progress)//TODO: ⚠️️ merge these 2 lines into one and make a method in SliderListUtils that returns point
         let verProg:CGFloat = SliderListUtils.progress(event.delta[.ver], /*5*/interval(.ver), slider(.ver).progress)*/
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        setProgress(progressVal)
//        (self as Slidable5).setProgress(progressVal)
        //(self as Scrollable5).setProgress(progressVal)
    }
    override func onInDirectScrollWheelChange(_ event:NSEvent) {//enables momentum
        super.onInDirectScrollWheelChange(event)
        onScrollWheelChange(event)
    }
    override func onScrollWheelEnter() {
        Swift.print("SliderScrollerHandler.onScrollWheelEnter")
        super.onScrollWheelEnter()
        showSlider()
    }
    override func onScrollWheelCancelled() {
        super.onScrollWheelEnter()
        hideSlider()
    }
    override func onScrollWheelExit() {
        Swift.print("SliderScrollerHandler.onScrollWheelExit")
        super.onScrollWheelExit()
        hideSlider()
    }
    override func onScrollWheelMomentumBegan(_ event:NSEvent) {
        super.onScrollWheelMomentumBegan(event)
        showSlider()//cancels out the hide call when onScrollWheelExit is called when you release after pan gesture
    }
    /**
     * Called only be called when scrollwheel becomes stationary. find the code that does this.
     */
    override func onScrollWheelMomentumEnded()  {
        super.onScrollWheelMomentumEnded()
        hideSlider()
    }
    /**
     * (0-1)
     */
    override func setProgress(_ point:CGPoint){
        Swift.print("SliderScrollerHandler.setProgress")
        super.setProgress(point)
        //Swift.print("🏂 Slidable3.setProgress: " + "\(point)")
        slider(.hor).setProgressValue(point.x)
        slider(.ver).setProgressValue(point.y)
    }
}
extension SliderScrollerHandler {
    /**
     * Updates the slider interval and the sliderThumbSize (after DP events: add/remove etc)
     */
    func updateSlider(){
        fatalError("not implemented yet")
        /*
         sliderInterval = floor(self.itemsHeight - height)/itemHeight
         let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
         slider!.setThumbHeightValue(thumbHeight)
         let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
         slider!.setProgressValue(progress)
         */
    }
    func hideSlider(){//convenience
        //        Swift.print("hide")
        hideSlider(.ver)
        hideSlider(.hor)
    }
    func showSlider(){//convenience
        //        Swift.print("show")
        showSlider(.ver)
        showSlider(.hor)
    }
    func hideSlider(_ dir:Dir){
        //Swift.print("🏂 hide slider dir: \(dir)")
        //self.slider!.thumb!.setSkinState("inActive")
        //if(slider(dir).thumb!.getSkinState() == SkinStates.none){slider(dir).thumb!.fadeOut()}/*only fade out if the state is none, aka not over*/
        //Swift.print("slider(dir).thumb!.getSkinState(): " + "\(slider(dir).thumb!.getSkinState())")
        if slider(dir).thumb.skinState == SkinStates.none {
            slider(dir).thumb.fadeOut()
        }
        /*slider(dir).thumb!.alpha = 0
         slider(dir).thumb!.skin?.decoratables[0].draw()*/
    }
    func showSlider(_ dir:Dir){
        //Swift.print("🏂 show slider dir: \(dir)")
        //slider(dir).thumb!.setSkinState(SkinStates.none)
        slider(dir).thumb.fadeIn()
        /*slider(dir).thumb!.alpha = 1
         slider(dir).thumb!.skin?.decoratables[0].draw()*/
    }
}
