import Foundation
/**
 * We could do selected instead of getSelected, but var getters confuse people. functions are easier to grasp. Its also easier to override functions conceptually than variables. Functions can also do method overloading.
 * NOTE: using isSelcted could be the wrong way to go about this-> getSelected would work better->*//*var isSelected:Bool{get}*//*This is named isSelected because selected is ocupied by obc and using selected() as a method seems inconsistent
 */
protocol ISelectable: class/*derive only classes for the protocol, not structs, this enables === operator of protocol and also enables inout support for protocols*/{
    func setSelected(isSelected:Bool)
    func getSelected()->Bool//<--shouldnt this be isSelected? :TODO: this should be getSelected since composite classes can impliment ICHeckable and they will need to access a sub instance via a implimcit getter method, same for IDisableable, ISelectable, IFocusable etc
}
extension ISelectable{/*<-- New, simplifes access, while maininting easy overriding abilities with the functions in the Iselectable protocol*/
    var selected:Bool {get{return getSelected()}set{ setSelected(newValue)}}
}