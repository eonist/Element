import Foundation

protocol IStyleCollection {
    var styles:Array<IStyle> {get}
    func addStyle(_ style:IStyle)
    func addStyles(_ styles:Array<IStyle>)
    func removeStyle(_ name:String)->IStyle?
    func getStyle(_ name:String)->IStyle?
    func getStyleAt(_ index:Int)->IStyle?
}
