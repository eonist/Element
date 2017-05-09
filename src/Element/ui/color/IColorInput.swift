import Cocoa
@testable import Utils

protocol IColorInput:IEventSender{//TODO:  ⚠️️ rename to ColorInoutKind?
    var color:NSColor?{get}
    func setColorValue(_ color:NSColor)
}
