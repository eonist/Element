import Foundation

protocol IStyle {
    /*getters / setters*/
    var name:String {get}
    var selectors:Array<ISelector> {get}
    var styleProperties:Array<IStyleProperty> {get set}
    /*core methods*/
    func addStyleProperty(styleProperty:IStyleProperty)
    func addStyleProperty(styleProperties:Array<IStyleProperty>)
    func addStyleProperties(styleProperties:Array<IStyleProperty>)
    /*implicit getters / setters*/
    func getStyleProperty(name:String,depth:Int)->IStyleProperty?
    func getValueAt(index:Int,depth:Int)->Any
    func getValue(name:String)->Any?
    func getStyleProperties(name:String)->Array<IStyleProperty>
    func getStylePropertyAt(index:Int)->IStyleProperty
}