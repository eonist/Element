import Foundation
/**
 * NOTE: Unlike Container, section can have a style applied
 * NOTE: you dont need anything in this method actually, the getClassType works if Section is the last SubClass in the subclass hierarchy
 */
class Section:Element {
    /*override func getClassType()->String{
    return String(Section)
    }*/
    override func onEvent(event: Event) {
        Swift.print("Section.event: " + "\(event)")
        super.onEvent(event)
    }
}
