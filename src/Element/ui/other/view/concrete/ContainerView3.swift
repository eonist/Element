import Cocoa
@testable import Utils

class ContainerView3:Element,Containable3 {
    var maskSize:CGSize {return CGSize(super.width,super.height)}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.width,super.height)}
    lazy var contentContainer:Element = {self.addSubView(Container(self.width,self.height,self,"lable"))}() //was content, but we want to use old css
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = contentContainer/*Inits the lazy instance*/
        //layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now 👍*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension ContainerView3 {//private maybe?
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
        // Swift.print("ContainerView3.scrollWheel")
        if(self is ElasticSlidableScrollableFastListable3){
            (self as! ElasticSlidableScrollableFastListable3).scroll(event)
        }else if(self is ElasticSlidableScrollable3){
            (self as! ElasticSlidableScrollable3).scroll(event)
        }else if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }else{
            fatalError("type not supported")
        }
        super.scrollWheel(with: event)
    }
}
