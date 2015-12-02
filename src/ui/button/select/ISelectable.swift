import Foundation

protocol ISelectable: class{
    func setSelected(isSelected:Bool)
    var selected:Bool{get}
}
