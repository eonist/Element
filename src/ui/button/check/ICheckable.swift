import Foundation

protocol ICheckable: class/*derive only classes for the protocol, not structs, this enables === operator of protocol*/{
    func setChecked(isChecked:Bool)
    //func getChecked()->Bool
    func getChecked()->Bool//<--shouldnt this be isChecked? :TODO: this should be getChecked since composite classes can impliment ICHeckable and they will need to access a sub instance via a implimcit getter method, same for IDisableable, ISelectable, IFocusable etc
}
//you probably have to revert to the checked variable as you need to be able to use only one way to assert checkedness. think checkgroup etc