import Foundation
/**
 * NOTE: ObjectC already has a class named Selector that may conflict with this one, use: this syntax instead if you need to use the ObjC Selector: ObjectiveC.Selector
 */
struct Selector:ISelector{//TODO: ⚠️️ this definitly needs to be converted to a struct
    let element:String/*Button*///should be nil
    let classIds:[String]/*.customButton*///should be nil
    let id:String/*#customButton*///should be nil
    let states:[String]/*:down*///should be nil
    init(_ element:String = "",_ classIds:[String] = [],_ id:String = "",_ states:[String] = []/*TODO: ""<-init with idle state?*/) {
        self.element = element
        self.classIds = classIds
        self.id = id
        self.states = states
    }
}
