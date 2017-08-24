import Foundation

protocol Disableable:SkinStateChangeable{
    var isDisabled:Bool {get set}
}
extension Disableable{
    func setDisabled(_ disabled:Bool){
        self.isDisabled = disabled
        self.skinState = {return skinState}()
        //you have to set: isInteractive = !disabled//This is the only way to disable things in NSView
    }
    func getDisabled()->Bool{
        return self.isDisabled
    }
}

