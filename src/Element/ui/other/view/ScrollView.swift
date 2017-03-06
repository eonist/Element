import Cocoa
@testable import Utils

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    /**
     * When the the user scrolls
     */
    override func scrollWheel(with event: NSEvent) {//swift 3 update
        scroll(event)/*forward the event to the extension which adjust Slider and calls setProgress in this method*/
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
    }
}
