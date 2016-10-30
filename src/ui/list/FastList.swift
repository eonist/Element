import Foundation

class FastList:Element {
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
        //Add 20 rects to a list (random colors) 100x50
        //mask 100x400
        
        //move a "virtual" list up and down by: (just by values) (see code for this in List.swift)
            //(the index of the item in the list) * itemHeight, represetnts the initY pos
            //when you move the "virtual" list up and down you add the .y value of the "virtual" list to every item
            //when an item is above the top or bellow the bottom of the mask, then remove it
        
        //You need a way to spawn items when they should be spawned (see legacy code for insp)
        
        //Basically 8 items can be viewable at the time (maxViewableItems = 8)
        //VirtualList.y = -200 -> how many items are above the top? -> use modulo -> think variable size though
        
        //Actually: store the visible item indecies in an array that you push and pop when the list goes up and down
            //This has the benefit that you only need to calc the height of the items in view (thinking about variable size support)
            //when an item goes above the top 
                //the index is removed from the visibleItemIndecies array
                //if the last index in visibleItemIndecies < items.count 
                    //append items[visibleItemIndecies.last] to visibleItemIndecies
                //it is moved to y:  visibleItems.last.y+visibleItems.last.height
        
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
