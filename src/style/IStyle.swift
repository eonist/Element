import Foundation

protocol IStyle {
    var name:String {get}
    var selectors:Array<ISelector> {get}
    var styleProperties:Array<IStyleProperty> {get set}
    func getStyleProperty(name:String)->IStyleProperty?
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
    func addStyleProperties(styleProperties:Array<IStyleProperty>)
}