import Foundation

class TreeListEvent:Event {
    static var change : String = "treeListEventChange";
    public function TreeListEvent(type : String,bubbles : Boolean = false, cancelable : Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
