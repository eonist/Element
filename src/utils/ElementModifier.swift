import Cocoa

class ElementModifier {
    /**
     * @Note refloats @param view children that are of type IElement
     * @Note i.e: after hideing of an element, or changing the depth order etc
     */
    class func floatChildren(view:NSView) {
        let numChildren:Int = view.subviews.count;
        for (var i : Int = 0; i < numChildren; i++) {
            let child:NSView = view.subviews[i]
            if(child is IElement) {SkinModifier.float((child as! IElement).skin as! Skin)}
        }
    }
}
