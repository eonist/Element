import Cocoa

class GradientSync {
    static var receiver:IGradientInput?
    static var broadcaster:IGradientInput?
    class func onGradientChange(event:GradientInputEvent){
        print("onGradientChange receiver:" + "\(GradientSync.receiver)")
        if(GradientSync.receiver != nil) {
            //print("_receiver: " + "\(ColorSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            GradientSync.broadcaster = event.origin as? IGradientInput
            GradientSync.receiver!.setGradient(event.gradient!)
            GradientSync.receiver!.onEvent(GradientInputEvent(GradientInputEvent.change,event.origin))
        }
    }
    /**
     * NOTE: this sets the color of the broadcaster not the receiver
     */
    class func setGradient(gradient:IGradient) {
        if (GradientSync.broadcaster != nil) {GradientSync.broadcaster!.setGradient(gradient)}
    }
}
