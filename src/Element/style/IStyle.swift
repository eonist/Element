import Foundation

protocol IStyle {//TODO:Rename to Stylable or StyleKind?
    var name:String {get}
    var selectors:[ISelector] {get}
    var styleProperties:[IStyleProperty] {get set}
}