import Foundation

protocol IStyle {
    var selectors:ISelector {get}
    var name:String {get}
    var styleProperties:Array<IStyleProperty> {get}
    func getStyleProperty(name:String)->IStyleProperty?
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
}