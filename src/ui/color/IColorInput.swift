import Cocoa

protocol IColorInput:IEventSender{
    var color:NSColor{get}
    func setColorValue(color:NSColor)
}