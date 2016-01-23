import Foundation
/**
 * NOTE: Unlike Container, section can have a style applied
 */
class Section:Element {
    
    
    //you dont need anything in this method actually, the getClassType works if Section is the last SubClass in the subclass hierarchy 
    
    
    /**
     * Returns "Section"
     * NOTE: This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType()->String{
        return String(Section)
    }
}
