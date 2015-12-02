import Foundation

protocol ISelectable: class{
    func setSelected(isSelected:Bool)
    func selected()->Bool
}
