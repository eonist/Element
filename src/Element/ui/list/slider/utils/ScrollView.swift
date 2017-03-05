import Cocoa

class ScrollView:Element,IScrollable{
    var lableContainer:Container?
    var itemsHeight:CGFloat = 600//override this
    var itemHeight:CGFloat = 24//override this
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        lableContainer = addSubView(Container(width,height,self,"lable"))
    }
}
