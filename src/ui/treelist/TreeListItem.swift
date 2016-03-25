import Foundation
/**
 * @Note: Keep the TreeListItem name, since you might want to create TreeMenuItem one day
 * // :TODO: why doesnt the treeListItem extend a class that ultimatly extends a TextButton?, has it something to do with the indentation via css?
 */
class TreeListItem {
    //var itemContainer : Container
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ isSelected:Bool = false, parent:IElement? = nil, id:String = "") {
        super.init(width, height, isFocused, isDisabled, text, isSelected, isChecked, parent, id, classId)
    }
}
