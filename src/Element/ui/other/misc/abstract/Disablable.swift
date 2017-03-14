import Foundation

protocol Disableable:StateChangeable{
    var isDisabled:Bool {get set}
}
extension Disableable{
    func setDisabled(_ disabled:Bool){
        self.isDisabled = disabled
        setSkinState(getSkinState())
        //you have to set: isInteractive = !disabled//This is the only way to disable things in NSView
    }
    func getDisabled()->Bool{
        return self.isDisabled
    }
}

