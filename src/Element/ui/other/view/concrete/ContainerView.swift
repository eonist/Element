import Cocoa
@testable import Utils
/**
 * ContainerView holds other UI elements
 */
class ContainerView:Element,Containable {
    
    //var height:CGFloat {fatalError("Must override in subClass")}
    //var interval:CGFloat {fatalError("Must override in subClass")}
    //var progress:CGFloat {fatalError("Must override in subClass")}
    var itemsHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    var itemHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    var lableContainer:Element?
    
    var maskSize:CGSize {return CGSize(width,height)}/*represents the visible part of the content *///TODO: could be ranmed to maskRect
    var contentSize:CGSize {return CGSize(itemsHeight,itemsHeight)}
    var itemSize:CGSize {return CGSize(itemHeight,itemHeight)}
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        lableContainer = addSubView(Container(width,height,self,"lable"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
    }
    /*override func getClassType()->String{
     return "\(ContainerView.self)"
     }*/
}
