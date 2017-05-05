import Foundation

protocol TreeKind {
    //associatedtype Element
    var children:[TreeKind] {get}
    var props:[String:String]? {get}
    var name:String? {get}
    var content:String? {get}//or use Any or T
}

