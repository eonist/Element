import Cocoa
@testable import Utils

class ContainerView3:Element,Containable3 {
    var maskSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}
    lazy var contentContainer:Element = self.createContentContainer() //was content, but we want to use old css
   override init(size:CGSize = CGSize(0,0),id:String? = nil){
        super.init(size:CGSize(size.width,size.height),id:id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = contentContainer/*Inits the lazy instance*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now 👍, Works!*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension ContainerView3 {//private maybe?
    /**
     * TODO: ⚠️️ Try to override with generics ContainerView<VerticalScrollable>  etc, in swift 4 this could probably be done with where Self:...
     */
    override open func scrollWheel(with event: NSEvent) {
        //Swift.print("ContainerView3.scrollWheel")
        if(self is ElasticSlidableScrollableFastListable3){
            (self as! ElasticSlidableScrollableFastListable3).scroll(event)
        }else if(self is ElasticSlidableScrollable3){
            (self as! ElasticSlidableScrollable3).scroll(event)
        }else if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }else{
            fatalError("type not supported: \(self)")
        }
        super.scrollWheel(with: event)
    }
    func createContentContainer() -> Container {
        return self.addSubView(Container(size:self.skinSize,id:"lable"))//<-- ⚠️️ misspelled
    }
}
