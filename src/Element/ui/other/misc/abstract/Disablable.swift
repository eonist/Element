import Foundation

protocol Disableable:class{
    var isDisabled:Bool {get set}
}
extension Disableable{
    func setDisabled(_ disabled:Bool){
        self.isDisabled = disabled
    }
    func getDisabled()->Bool{
        return self.isDisabled
    }
}

