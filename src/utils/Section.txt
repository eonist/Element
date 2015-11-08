import Foundation
class Section:Element {//Unlike Container, section can have a style applied
    override init(_ width:Int = 100, _ height:Int = 100, _ parent:IElement? = nil) {
        super.init(width,height,parent)
    }
    /*
     * Required by super class 
     * TODO: could we add it thorugh extions instead?
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     * Returns "Section"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType()->String{
        return String(Section)
    }
}