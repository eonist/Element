import Foundation
/**
 * NOTE: Unlike Container, section can have a style applied
 */
class Section:Element {
    /**
     * Returns "Section"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType()->String{
        return String(Section)
    }
}
