import Foundation

typealias IStyleCollection = StyleCollectionKind
protocol StyleCollectionKind {
    var styles:[Stylable] {get set}
}
/*func addStyle(_ style:IStyle)
 func addStyles(_ styles:[IStyle])
 func removeStyle(_ name:String)->IStyle?
 func getStyle(_ name:String)->IStyle?
 func getStyleAt(_ index:Int)->IStyle?*/
