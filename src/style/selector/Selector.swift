import Foundation
/**
 * NOTE: ObjectC already has a class named Selector that may conflict with this one, use: this syntax instead if you need to use the ObjC Selector: ObjectiveC.Selector
 */
struct Selector:ISelector{// :TODO: you should probably use a struct instead of class in the future
    let element:String/*Button*///should be nil
    let classIds:Array<String>/*.customButton*///should be nil
    let id:String/*#customButton*///should be nil
    let states:Array<String>/*:down*///should be nil
    init(_ element:String = "",_ classIds:Array<String> = [],_ id:String = "",_ states:Array<String> = []/*TODO: ""<-init with idle state?*/) {
        self.element = element
        self.classIds = classIds
        self.id = id
        self.states = states
    }
}