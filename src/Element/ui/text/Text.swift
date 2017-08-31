import Cocoa
@testable import Utils

class Text:Element,TextKind{
    let initText:String//this value is accessed by the TextSkin (It is not meant for external accessing from other classes)
//    override var skinSize: CGSize {
//        get {
//            if let skin = skin {
//                return CGSize(skin.getWidth(),getHeight())
//            }
//            return super.skinSize
//
//        }
//        set {super.skinSize = newValue}
//    }
    init(text:String,size:CGSize = CGSize(0,0),id:String? = nil){
        initText = text
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
//        Swift.print("Text resolveSkin.completed")
    }
    /**
     * Returns "Text"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return "\(Text.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //DEPRECATED:
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ parent:ElementKind? = nil, _ id:String? = nil){
        initText = text
        super.init(size:CGSize(width,height),id:id)
    }
}
