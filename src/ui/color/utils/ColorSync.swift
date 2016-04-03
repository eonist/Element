import Cocoa
/**
 * let singleton = ColorSync.sharedInstance
 * singleton.test()
 */
class ColorSync {
    static let sharedInstance = ColorSync()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    static var receiver:IColorInput?
    static var broadcaster:IColorInput?
    class func onColorChange(event:ColorInputEvent){
        print("onColorChange" + "\(ColorSync.receiver)")
        if(ColorSync.receiver != nil) {
            print("_receiver: " + "\(ColorSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            ColorSync.broadcaster = event.origin as? IColorInput
            ColorSync.receiver!.setColorValue(event.color)
            ColorSync.receiver!.onEvent(ColorInputEvent(ColorInputEvent.change,event.color))
        }
    }
    class func setColor(color:NSColor) {
        if (ColorSync.broadcaster != nil) {ColorSync.broadcaster!.setColorValue(color)}
    }
}

