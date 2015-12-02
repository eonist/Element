import Foundation

protocol ISelectable: class{
    func setSelected(isSelected:Bool)
    var isSelected:Bool{get}/*This is named isSelected because selected is ocupied by obc and using selected() as a method seems inconsistent*/
}
