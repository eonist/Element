import Cocoa
@testable import Utils

class Text:Element,TextKind {
    var initText:String//this value is accessed by the TextSkin (It is not meant for external accessing from other classes)
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ parent:ElementKind? = nil, _ id:String? = nil){
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
    private enum CodingKeys:String,CodingKey {
        case id,width,height,text
    }
    required init(from decoder:Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)
        let id = try allValues.decodeIfPresent(String.self,forKey:.id)
        let width = try allValues.decodeIfPresent(CGFloat.self,forKey:.width) ?? 0
        let height = try allValues.decodeIfPresent(CGFloat.self,forKey:.height) ?? 0
        initText = try allValues.decodeIfPresent(String.self,forKey:.text) ?? "defaultText"
        super.init(width, height, nil, id)
        
        //do research and figure out if you can get the addSubView call
        
        //Make inits with excplicit args
        
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
