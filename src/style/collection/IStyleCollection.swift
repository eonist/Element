import Foundation

protocol IStyleCollection {
    var styles:Array<IStyle> {get}
    func addStyle(style:IStyle)
    func addStyles(styles:Array<IStyle>)
    func removeStyle(name:String)->IStyle
    func getStyle(name:String)->IStyle
    func getStyleAt(index:Int)->IStyle
}