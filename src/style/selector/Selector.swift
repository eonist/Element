import Foundation

class Selector:ISelector{// :TODO: impliment a ISelector interface, you should probably use a struct instead of class in the future
    var element:String//should be nil
    var classIds:Array<String>//should be nil
    var id:String//should be nil
    var states:Array<String>//should be nil
    init(_ element:String = "",_ classIds:Array<String> = [],_ id:String = "",_ states:Array<String> = [""]) {
        self.element = element;
        self.classIds = classIds;
        self.id = id;
        self.states = states;
    }
}