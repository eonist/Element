import Cocoa

class GradientSync {
    static var receiver:IGradientInput?
    static var broadcaster:IGradientInput?
    class func onGradientChange(event:GradientInputEvent){
        print("GradientSync.onGradientChange receiver:" + "\(GradientSync.receiver)")
        if(GradientSync.receiver != nil) {
            //print("_receiver: " + "\(GradientSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            GradientSync.broadcaster = event.origin as? IGradientInput
            GradientSync.receiver!.setGradient(event.gradient!)
            GradientSync.receiver!.onEvent(GradientInputEvent(GradientInputEvent.change,event.origin))
        }
    }
}
extension GradientSync{
    /**
     * NOTE: this sets the gradient of the receiver
     */
    class func setRecieverGradient(gradient:IGradient){
        if (GradientSync.receiver != nil) {GradientSync.receiver!.setGradient(gradient)}
    }
    /**
     * NOTE: this sets the gradient of the broadcaster
     */
    class func setBroadcasterGradient(gradient:IGradient){
        if (GradientSync.broadcaster != nil) {GradientSync.broadcaster!.setGradient(gradient)}
    }
}