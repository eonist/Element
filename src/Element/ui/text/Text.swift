import Cocoa
@testable import Utils

class Text:Element,IText {
    var initText:String;//this value is accessed by the TextSkin (It is not meant for external accessing from other classes)
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "dafaultText", _ parent:IElement? = nil, _ id:String? = nil){
        initText = text
        super.init(width, height, parent, id)
    }
    /**
     * Returns "Text"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade, in the event that a class subclasses this class
     */
    override func getClassType() -> String {
        return "\(Text.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
