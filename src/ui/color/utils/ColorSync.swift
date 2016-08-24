import Cocoa
/**
 * let singleton = ColorSync.sharedInstance
 * singleton.test()
 * NOTE: the way it works is that the broadcaster and receiver are set by the user interaction with the GUI, and then you call ColorSync.onColorChange(event as! ColorInputEvent) and ColorSync decides what is receiving at that point in time
 */
class ColorSync {
    static let sharedInstance = ColorSync()//TODO:IDont think this needs to be a singleton
    private init() {} //This prevents others from using the default '()' initializer for this class.
    static var receiver:IColorInput?
    static var broadcaster:IColorInput?
    class func onColorChange(event:ColorInputEvent){
        print("ColorSync.onColorChange" + "\(ColorSync.receiver)")
        if(ColorSync.receiver != nil) {
            print("_receiver: " + "\(ColorSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            ColorSync.broadcaster = event.origin as? IColorInput
            ColorSync.receiver!.setColorValue(event.color!)
            ColorSync.receiver!.onEvent(ColorInputEvent(ColorInputEvent.change,event.origin))
        }
    }
    /**
     * NOTE: this sets the color of the broadcaster not the receiver
     */
    class func setColor(color:NSColor) {
        if (ColorSync.broadcaster != nil) {ColorSync.broadcaster!.setColorValue(color)}
    }
}