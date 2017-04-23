import Foundation

protocol IStyle {
    /*Getters / Setters*/
    var name:String {get}
    var selectors:[ISelector] {get}
    var styleProperties:[IStyleProperty] {get set}
    /*Core methods*/
    /*func addStyleProperty(_ styleProperty:IStyleProperty)
     func addStyleProperty(_ styleProperties:[IStyleProperty])
     func addStyleProperties(_ styleProperties:[IStyleProperty])*/
    /*Implicit getters / setters*/
    /*func getStyleProperty(_ name:String,_ depth:Int)->IStyleProperty?
     func getValueAt(_ index:Int)->Any
     func getValue(_ name:String,_ depth:Int)->Any?
     func getStyleProperties(_ name:String)->[IStyleProperty]
     func getStylePropertyAt(_ index:Int)->IStyleProperty*/
}

