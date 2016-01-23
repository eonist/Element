import Foundation
/**
 * NOTE: Unlike Container, section can have a style applied
 */
class Section:Element {
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        super.init(width, height, parent, id)
    }
    func resolveSkin() {
        su
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class */
    /**
     * Returns "Section"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType()->String{
        return String(self.dynamicType)
    }
}
