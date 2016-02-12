import Foundation

protocol ICheckable {
    func setChecked(isChecked:Bool)
    var isChecked:Bool{get}// :TODO: this should be getChecked since composite classes can impliment ICHeckable and they will need to access a sub instance via a implimcit getter method, same for IDisableable, ISelectable, IFocusable etc
}
