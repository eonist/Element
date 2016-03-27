import Foundation
/**
 * “Unselect” vs “Deselect”: Unselected is used to qualify something that has not been selected, not something that was selected and isn't anymore.
 * NOTE: to get the selected state: ((sender as! NSNotification).object as ISelectable).isSelected
 */
class SelectEvent:Event {
    static var select:String = "select"
    //static var deSelect:String = "deSelect"//unSelect is also an option?
}
extension SelectEvent{
    var isSelected:Bool{return (origin as! ISelectable).isSelected}
}