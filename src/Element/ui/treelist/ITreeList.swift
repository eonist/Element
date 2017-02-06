import Cocoa

protocol ITreeList:IElement {
    var itemContainer:Container?{get}
    func addItem(_ item:NSView)
    func addItemAt(_ item:NSView,_ index:Int)
    func getCount() -> Int
    func removeAt(_ index:Int)
}
