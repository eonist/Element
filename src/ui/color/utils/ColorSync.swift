import Foundation
/**
 * let singleton = ColorSync.sharedInstance
 * singleton.test()
 */
class ColorSync {
    static let sharedInstance = ColorSync()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    private static var _receiver:IColorInput;
    private static var _broadcaster:IColorInput;
    public static function onColorChange(event:ColorInputEvent):void{
    trace("onColorChange"+_receiver);
    if(_receiver != null) {
				trace("_receiver: " + _receiver);
    //				trace("event.target: " + event.target);
    //				trace("event.currentTarget: " + event.currentTarget);
				_broadcaster = event.target as IColorInput;
				_receiver.setColor(event.color);
				_receiver.dispatchEvent(new ColorInputEvent(ColorInputEvent.CHANGE,event.color));
    }
}

