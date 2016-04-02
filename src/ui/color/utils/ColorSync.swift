import Foundation
/**
 * let singleton = ColorSync.sharedInstance
 * singleton.test()
 */
class ColorSync {
    static let sharedInstance = ColorSync()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    static var receiver:IColorInput?
    static var broadcaster:IColorInput?
    func onColorChange(event:ColorInputEvent){
        print("onColorChange" + "\(ColorSync.receiver)")
        if(ColorSync.receiver != nil) {
            print("_receiver: " + "\(ColorSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            ColorSync.broadcaster = event.target as IColorInput
            ColorSync.receiver.setColor(event.color)
            ColorSync.receiver.onEvent(ColorInputEvent(ColorInputEvent.change,event.color))
        }
    }
    public static function setColor(color:Number):void {
    if (_broadcaster != null) _broadcaster.setColor(color);
    }
}

