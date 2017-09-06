import Cocoa
@testable import Utils

class ProgressableList5:List5,ProgressableDecorator {
    
    var progressable: Progressable5 {return self}//move this somewhere else
    
    lazy var handler:ProgressHandler = .init(progressable:self)//⚠️️ rename to handler and make it override somehow
}
