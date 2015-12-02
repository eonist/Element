import Foundation

protocol ISelectable: class/*derive only classes for the protocol, not structs, this enables === operator of protocol*/{
    func setSelected(isSelected:Bool)
    var isSelected:Bool{get}/*This is named isSelected because selected is ocupied by obc and using selected() as a method seems inconsistent*/
}
