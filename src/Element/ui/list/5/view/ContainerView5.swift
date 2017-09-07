import Cocoa
@testable import Utils
/**
 *
 */
class ContainerView5:Element,Containable5 {
    var maskSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    var contentSize:CGSize {return CGSize(super.skinSize.w,super.skinSize.h)}//override this in subClasses if content is of a different size
    lazy var contentContainer:Element = self.createContentContainer() //was content, but we want to use old css
    override init(size:CGSize = CGSize(0,0),id:String? = nil){
        super.init(size:CGSize(size.width,size.height),id:id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = contentContainer/*Inits the lazy instance*/
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now 👍, Works!*/
    }
    override func getClassType() -> String {//new
        return "ContainerView"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension ContainerView5 {//private maybe?
    func createContentContainer() -> Container {
        return self.addSubView(Container(size:self.skinSize,id:"lable"))//<-- ⚠️️ misspelled
    }
}


