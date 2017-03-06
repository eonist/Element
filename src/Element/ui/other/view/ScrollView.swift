import Cocoa
@testable import Utils

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat {fatalError("Must be override in subClass")}//override this for custom value
    var itemHeight:CGFloat {fatalError("Must be override in subClass")}//override this for custom value
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
