import Foundation

class ListEvent : Event{
    
    private var index : Int
    init(_ type: String, _ index:Int, _ origin: AnyObject) {
        //selected:ISelectable
        //private var selected : ISelectable
        self.index = index
        super.init(type, origin)
    }
}
