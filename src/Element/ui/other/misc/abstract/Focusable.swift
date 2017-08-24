import Foundation

protocol Focusable:SkinStateChangeable{
    var isFocused:Bool {get set}
}
extension Focusable{
    func setFocused(_ focused:Bool){
        self.isFocused = focused
        self.skinState = {return skinState}()
    }
    func getFocused()->Bool{
        return self.isFocused
    }
}

