import Foundation

protocol IColorPanel:IColorInput{
    var spinner1:LeverSpinner {get}
    var spinner2:LeverSpinner {get}
    var spinner3:LeverSpinner {get}
    func getColorType() -> String
}
