import Cocoa
@testable import Utils
@testable import Element
/**
 * Slidable is for Elements that has a slider attached
 */
protocol Slidable3:Progressable3 {
    var horSlider:Slider? {get}
    var verSlider:Slider? {get}
    /*func updateSlider()*/
    func slider(_ dir:Dir) -> Slider/*?*/
}
/**
 * ⚠️️ IMPORTANT: Slidable does not override scroll because a SlideView can't detect scroll. SlideScrollView however can access scroll and call hide and show slider. And then use protocol ambiguity to call scroll on the Scrollable after
 */
extension Slidable3 {
    /*NOTE: If you need only one slider, then override both hor and ver with this slider*/
    func slider(_ dir:Dir) -> Slider { return dir == .ver ? verSlider! : horSlider!}/*Convenience*/
    /**
     * (0-1)
     */
    func setProgress(_ point:CGPoint){
        Swift.print("🏂 Slidable3.setProgress: " + "\(point)")
        slider(.hor).setProgressValue(point.x)
        slider(.ver).setProgressValue(point.y)
    }
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
        Swift.print("hide")
        hideSlider(.ver)
        hideSlider(.hor)
    }
    func showSlider(){//convenience
        Swift.print("show")
        showSlider(.ver)
        showSlider(.hor)
    }
    func hideSlider(_ dir:Dir){
        //Swift.print("🏂 hide slider dir: \(dir)")
        //self.slider!.thumb!.setSkinState("inActive")
        //if(slider(dir).thumb!.getSkinState() == SkinStates.none){slider(dir).thumb!.fadeOut()}/*only fade out if the state is none, aka not over*/
        //Swift.print("slider(dir).thumb!.getSkinState(): " + "\(slider(dir).thumb!.getSkinState())")
        if(slider(dir).thumb!.getSkinState() == SkinStates.none){
            slider(dir).thumb!.fadeOut()
        }
        /*slider(dir).thumb!.alpha = 0
         slider(dir).thumb!.skin?.decoratables[0].draw()*/
    }
    func showSlider(_ dir:Dir){
        //Swift.print("🏂 show slider dir: \(dir)")
        //slider(dir).thumb!.setSkinState(SkinStates.none)
        slider(dir).thumb!.fadeIn()
        /*slider(dir).thumb!.alpha = 1
         slider(dir).thumb!.skin?.decoratables[0].draw()*/
    }
}
/* func setProgress(_ progress:CGFloat, _ dir:Dir) {
 slider(dir).setProgressValue(progress)
 }*/

//func sliderInterval(_ dir:Dir)->CGFloat/*?{get set}*///I think this is the same as intervall, remove
