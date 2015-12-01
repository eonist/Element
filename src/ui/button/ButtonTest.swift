import Cocoa

protocol IButton{
    func someMethod()
}

//continue testing how you can add protocol to Classes that cant extend

extension NSButton:IButton{
    public override func drawRect(dirtyRect: NSRect) {
        //do something
        someMethod()
    }
    
}

extension IButton{
    func someMethod() {
        //do somthing
        Swift.print("works")
    }
}