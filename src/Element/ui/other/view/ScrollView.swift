import Cocoa
@testable import Utils

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat = 600//override this for custom value
    var itemHeight:CGFloat = 24//override this for custom value
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
