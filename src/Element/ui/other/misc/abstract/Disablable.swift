import Foundation

protocol Disableable:StateChangeable{
    var isDisabled:Bool {get set}
}
extension Disableable{
    func setDisabled(_ disabled:Bool){
        self.isDisabled = disabled
        setSkinState(getSkinState())
    }
    func getDisabled()->Bool{
        return self.isDisabled
    }
}

