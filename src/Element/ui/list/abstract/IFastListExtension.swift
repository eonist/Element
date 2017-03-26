import Foundation
@testable import Utils

extension IFastList {
    /**
     * Returns the first item that visible within view. (item.bottom must cross top of view to count as visible)
     */
    var firstVisibleItem:Int{
        let a = abs(lableContainer!.y)//force positive value with abs
        let b = a/itemHeight//how many items fit into "a"
        let c = floor(b)//Continue here
        let firstVisibleItem:Int = c.int
        //Swift.print("firstVisibleItem: " + "\(firstVisibleItem)")
        return firstVisibleItem
    }
    /**
     * Returns the last item that is visible within view (item top has not crossed bottom of view)
     * NOTE: the existens of item at this index is not garantued. Its the virtual idx of such an item
     */
    var lastVisibleItem:Int{
        let a:Int = firstVisibleItem
        let b = height/itemHeight
        //Swift.print("b: " + "\(b)")
        let c = ceil(b)
        //Swift.print("c: " + "\(c)")
        let d = c == 0 ? 0 : c + 1//add an extra item to cover the area. should be dealt with in the render method really
        //Swift.print("d: " + "\(d)")
        let lastVisibleItem:Int = a + d.int
        //Swift.print("lastVisibleItem: " + "\(lastVisibleItem)")
        return lastVisibleItem
    }
    /**
     * Returns number of items that can fit height
     */
    var numOfItemsThatCanFit:Int {
        return floor(height/itemHeight).int
    }
    /**
     * Alignes the lableContainer after its content has been changed (add/remove of item)
     */
    func alignLableContainer(_ event:DataProviderEvent){
        /*Pin to top if itemsHeight is less than height*/
        if(itemsHeight < height){//basically when itemsHeight is less than height was /*dp.count <= numOfItemsThatCanFit*/
            lableContainer!.y = 0
        }
            /*Pin to bottom if (lableContainer.y + itemsHeight) is less than (height) and itemsHeight is more than height*/
        else if(itemsHeight > height){
            if((lableContainer!.y + itemsHeight) < height){
                lableContainer!.y = -(itemsHeight - height)
            }
        }
        /*If an item is added / removed above the first visible item*/
        else if(event.startIndex < firstVisibleItem){
            if(event.type == DataProviderEvent.remove){
                lableContainer!.y += itemHeight
                Swift.print("offset.y + 24")
            }else if(event.type == DataProviderEvent.add){
                lableContainer!.y -= itemHeight
                Swift.print("offset.y - 24")
            }
        }
    }

}
