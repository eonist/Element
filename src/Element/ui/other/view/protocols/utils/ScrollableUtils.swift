import Foundation

class ScrollableUtils {
    /**
     * Scrolls the list to a scalar position (value 0-1)
     */
    static func scrollTo(_ scrollable: Displaceable, _ progress:CGFloat){
        let y:CGFloat = ScrollableUtils.scrollTo(progress, scrollable.height, scrollable.itemsHeight)
        scrollable.lableContainer!.y = y/*we offset the y position of the lableContainer*/
    }
    /**
     * Returns the y position of a "virtual" list
     */
    static func scrollTo(_ progress:CGFloat,_ maskHeight:CGFloat,_ itemsHeight:CGFloat)->CGFloat{
        let scrollHeight:CGFloat = itemsHeight - maskHeight/*allItems.height - mask.height*/
        //Swift.print("scrollHeight: " + "\(scrollHeight)")
        /*
         if(scrollHeight.isNegative && progress.isNegative){
         scrollHeight = scrollHeight * -1//Swift.max(scrollHeight,0)
         }
         Swift.print("progress: " + "\(progress)")
         Swift.print("scrollHeight: " + "\(scrollHeight)")
         */
        //continue here: get both directions working, clip the values in sliderlist only
        
        let y:CGFloat = round(progress * scrollHeight)//Things may actually be smoother if you remove the round variable
        return -y
    }
}
//⚠️️ DEPRECATED; remove
extension ScrollableUtils{
    /**
     * Scrolls the list to a scalar position (value 0-1)
     */
    static func scrollTo(_ scrollable:IScrollable,_ progress:CGFloat){
        let y:CGFloat = ScrollableUtils.scrollTo(progress, scrollable.height, scrollable.itemsHeight)
        scrollable.lableContainer!.y = y/*we offset the y position of the lableContainer*/
    }
}
