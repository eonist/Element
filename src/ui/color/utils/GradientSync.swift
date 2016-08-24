import Cocoa

class GradientSync {
    static var receiver:IGradientInput?
    static var broadcaster:IGradientInput?
    class func onGradientChange(event:ColorInputEvent){
        print("onColorChange" + "\(ColorSync.receiver)")
        if(ColorSync.receiver != nil) {
            print("_receiver: " + "\(ColorSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            ColorSync.broadcaster = event.origin as? IColorInput
            ColorSync.receiver!.setColorValue(event.color!)
            ColorSync.receiver!.onEvent(ColorInputEvent(ColorInputEvent.change,event.color!))
        }
    }
    /**
     * NOTE: this sets the color of the broadcaster not the receiver
     */
    class func setColor(color:NSColor) {
        if (ColorSync.broadcaster != nil) {ColorSync.broadcaster!.setColorValue(color)}
    }

}
