import Cocoa

protocol ITreeList:IElement {
    var itemContainer:Container?{get}
    func addItem(item:NSView)
    func addItemAt(item:NSView,_ index:Int)
    func getCount() -> Int
    func removeAt(index:Int)
}