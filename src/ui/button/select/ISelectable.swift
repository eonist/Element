import Foundation

protocol ISelectable: class/*derive only classes for the protocol, not structs, this enables === operator of protocol*/{
    func setSelected(isSelected:Bool)
    /*using isSelcted could be the wrong way to go about this-> getSelected would work better->*//*var isSelected:Bool{get}*//*This is named isSelected because selected is ocupied by obc and using selected() as a method seems inconsistent*/
    //func getSelected()->Bool//<--shouldnt this be isSelected? :TODO: this should be getChecked since composite classes can impliment ICHeckable and they will need to access a sub instance via a implimcit getter method, same for IDisableable, ISelectable, IFocusable etc
    var selected:Bool{get}
}
