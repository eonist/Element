import Foundation

class TreeListModifier {
    /**
     * Scrolls the treeList to a scalar position (value 0-1)
     */
    public static function scrollTo(treeList:ITreeList,progress:Number):void{
    treeList.itemContainer.y = SliderParser.y(progress, treeList.getHeight(),  TreeListParser.itemsHeight(treeList));;
    }
}
