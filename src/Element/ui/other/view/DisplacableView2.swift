import Cocoa

class DisplaceView2:Element,Displacable2 {
    var height:CGFloat {fatalError("Must override in subClass")}
    var interval:CGFloat {fatalError("Must override in subClass")}
    var progress:CGFloat {fatalError("Must override in subClass")}
    var itemContainer:Container
    //func scrollWheel(_ event:String){}
    var itemsHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    var itemHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = self.addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
}
