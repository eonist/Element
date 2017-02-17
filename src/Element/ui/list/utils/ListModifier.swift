import Foundation
@testable import Utils

class ListModifier {
    /**
     * Selects the first item that has @param title as its title
     */
    static func select(_ list:IList, _ title:String) {
        let index:Int = list.dataProvider.getItemIndex(list.dataProvider.getItem(title)!)
        selectAt(list,index)
    }
    /**
     * Selects an item in the itemContainer
     */
    static func selectAt(_ list:IList,_ index:Int) {
        let selectable:ISelectable = list.lableContainer!.subviews[index] as! ISelectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer!)
    }
    /**
     * Scrolls the list to a scalar position (value 0-1)
     */
    static func scrollTo(_ list:IList,_ progress:CGFloat){
        let y:CGFloat = ListModifier.scrollTo(progress, list.height, list.itemsHeight)
        list.lableContainer!.y = y/*we offset the y position of the lableContainer*/
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
