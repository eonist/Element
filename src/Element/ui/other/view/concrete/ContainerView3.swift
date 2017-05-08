import Cocoa
@testable import Utils

class ContainerView3:Element,Containable3 {
    var maskSize:CGSize {return CGSize(super.width,super.height)}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.width,super.height)}
    var contentContainer:Element?//TODO: ⚠️️ make this into lazy
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        contentContainer = addSubView(ProgressContainer(width,height,self,"lable"))//was content, but we want to use old css
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now 👍*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ProgressContainer:Container{
    /**
     * A clever hack when using layer.position to move things
     */
    override func hitTest(_ aPoint:NSPoint) -> NSView? {
        Swift.print("ProgressContainer.layer!.position: " + "\(layer!.position)")
        let aPoint = aPoint + CGPoint(layer!.position.x,layer!.position.y)
        return super.hitTest(aPoint)
    }
    override func getClassType() -> String {
        return "\(Container.self)"
    }
}
