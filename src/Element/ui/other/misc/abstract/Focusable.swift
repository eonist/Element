import Foundation

protocol Focusable:class{
    var isFocused:Bool {get set}
}
extension Focusable{
    func setFocused(_ focused:Bool){
        self.isFocused = focused
    }
    func getFocused()->Bool{
        return self.isFocused
    }
}

