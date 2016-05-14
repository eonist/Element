import Foundation

class StyleProperty:IStyleProperty {
    var name : String
    var value : Any
    var depth : Int/*Depth should really be UInt, but since apple doesnt use/like UInt and the support isnt that great we use Int*/
    /**
     *
     */
    init(_ name:String,_ value:Any,_ depth:Int = 0){
        self.name = name
        self.value = value
        self.depth = depth
    }
}