import Foundation

protocol Focusable:StateChangeable{
    var isFocused:Bool {get set}
}
extension Focusable{
    func setFocused(_ focused:Bool){
        self.isFocused = focused
        setSkinState(getSkinState())
    }
    func getFocused()->Bool{
        return self.isFocused
    }
}

