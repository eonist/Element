import Cocoa
/**
 * NOTE: You forward the scrollWheel events here
 * NOTE: It all works like a regular MVC system
 * TODO: Create the algorithm that calculates the actual throw speed. By looking at the time that each intervall travles. 
 * PARAM: frame: represents the visible part of the content //TODO: could be ranmed to maskRect
 * PARAM: itemsRect: represents the total size of the content //TODO: could be ranmed to contentRect
 * TODO: You could make a class named ScrollController that doesnt have the rubberband and then extend it
 * TODO: Maybe create var's that store the enter and exit state.
 * TODO: It could be possible to do all the methods i this class as an extension to IRBSliderList, and have the mover,prescorldeltay and velocites in Rbsliderlist instead
 */

//Continue here: Check the swipe left right code for state code for enter and exit.

class RBScrollController:EventSender{
    //var view:RBSliderList/*holds a ref to the view*/
    
    init(_ callBack:(CGFloat)->Void,_ frame:CGRect, _ itemRect:CGRect){
        //self.view = view
       
    }
    
    /*
    override func onEvent(event:Event) {
        //Swift.print("RBScrollController.onEvent()")
        super.onEvent(event)
    }
    */
}
