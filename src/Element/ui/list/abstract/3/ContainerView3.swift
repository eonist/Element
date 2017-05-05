import Cocoa
@testable import Utils
@testable import Element

class ContainerView3:Element,Containable3 {
    var maskSize:CGSize {return CGSize(super.width,super.height)}/*represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.width,super.height)}
    var contentContainer:Element?
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        //maskSize = CGSize(width,height)
        //contentSize = CGSize(width,height)
        super.init(width, height)
    }
    override func resolveSkin() {
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"lable"))//was content, but we want to use old css
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now 👍*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

