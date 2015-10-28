import Foundation

class StyleProperty:IStyleProperty {
    var name : String
    var value : Any
    /**
    *
    */
    init(_ name:String,_ value:Any){
        self.name = name
        self.value = value
    }
}