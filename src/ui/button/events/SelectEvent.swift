import Foundation
/**
 * “Unselect” vs “Deselect”: Unselected is used to qualify something that has not been selected, not something that was selected and isn't anymore.
 * NOTE: to get the selected state: ((sender as! NSNotification).object as ISelectable).isSelected
 */
class SelectEvent {
    static var select:String = "select"
    //static var deSelect:String = "deSelect"//use
}
