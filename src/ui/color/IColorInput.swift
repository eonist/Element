import Cocoa
@testable import Utils

protocol IColorInput:IEventSender{
    var color:NSColor?{get}
    func setColorValue(_ color:NSColor)
}
