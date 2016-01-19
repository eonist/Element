import Foundation

protocol IStyle {
    var name:String {get}
    var selectors:Array<ISelector> {get}
    var styleProperties:Array<IStyleProperty> {get set}
    /*core methods*/
    func getStyleProperty(name:String)->IStyleProperty?
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
    func addStyleProperties(styleProperties:Array<IStyleProperty>)
    func getValueAt(index:Int)->Any
    func getValue(name:String)->Any?
    func getStyleProperties(name:String)->Array<IStyleProperty>
    func getStylePropertyAt(index:Int)->IStyleProperty
}