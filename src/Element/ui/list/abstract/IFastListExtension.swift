import Foundation
@testable import Utils

extension IFastList {
    /**
     * Returns the first item that visible within view. (item.bottom must cross top of view to count as visible)
     */
    var firstVisibleItem:Int{
        let a = abs(lableContainer!.point[dir])//force positive value with abs
        let b = a/itemSize[dir]//how many items fit into "a"
        let c = floor(b)//Continue here
        let firstVisibleItem:Int = c.int
        return firstVisibleItem
    }
    /**
     * Returns the last item that is visible within view (item top has not crossed bottom of view)
     * NOTE: the existens of item at this index is not garantued. Its the virtual idx of such an item
     */
    var lastVisibleItem:Int{
        let a:Int = firstVisibleItem
        let b = maskSize[dir]/itemSize[dir]
        let c = ceil(b)
        let d = c == 0 ? 0 : c + 1//add an extra item to cover the area. should be dealt with in the render method really
        let lastVisibleItem:Int = a + d.int
        return lastVisibleItem
    }
    /**
     * Returns number of items that can fit height
     */
    var numOfItemsThatCanFit:Int {
        return floor(maskSize[dir]/itemSize[dir]).int
    }
    /**
     * Alignes the lableContainer after it's content has been changed (add/remove of item)
     * NOTE: This method makes the Fast list look good when item sout of view vanish. Scroll is realigned and you can continue from where you are
     * NOTE: called by FastList.onDataProviderEvent
     */
    func alignLableContainer(_ event:DataProviderEvent){
        /*Pin to top if itemsHeight is less than height*/
        if(contentSize[dir] < maskSize[dir]){//basically when itemsHeight is less than height was /*dp.count <= numOfItemsThatCanFit*/
            lableContainer!.point[dir] = 0
        }
        /*Pin to bottom if (lableContainer.y + itemsHeight) is less than (height) and itemsHeight is more than height*/
        
        Swift.print("⚠️️⚠️️⚠️️⚠️️IFASSTLISTEXTENSION. CAUTION THE BELLOW HAS A BUG⚠️️⚠️️⚠️️⚠️️ ")
        //use contentsize and masksize in the bellow line
        else if(itemsHeight > height){
            if((lableContainer!.point[dir] + contentSize[dir]) < maskSize[dir]){
                lableContainer!.point[dir] = -(contentSize[dir] - maskSize[dir])
            }
        }
        /*If an item is added / removed above the first visible item*/
        else if(event.startIndex < firstVisibleItem){
            if(event.type == DataProviderEvent.remove){
                lableContainer!.point[dir] += itemSize[dir]
                //Swift.print("offset.y + 24")
            }else if(event.type == DataProviderEvent.add){
                lableContainer!.point[dir] -= itemSize[dir]
                //Swift.print("offset.y - 24")
            }
        }
    }
}
