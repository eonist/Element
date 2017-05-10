import Foundation
/**
 * Depth should really be UInt, but since apple doesnt use/like UInt and the support isn't that great we use Int
 */
struct StyleProperty:IStyleProperty {
    var name:String
    var value:Any
    var depth:Int
    init(_ name:String,_ value:Any,_ depth:Int = 0){
        self.name = name
        self.value = value
        self.depth = depth
    }
}
