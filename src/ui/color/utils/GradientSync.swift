import Cocoa

class GradientSync {
    static var receiver:IGradientInput?//this should be only settable from outside not gettable
    static var broadcaster:IGradientInput?//this should be only settable from outside not gettable
    class func onGradientChange(event:GradientInputEvent){
        print("GradientSync.onGradientChange receiver:" + "\(GradientSync.receiver)")
        if(GradientSync.receiver != nil) {
            //print("_receiver: " + "\(GradientSync.receiver)")
            //print("event.target: " + event.target);
            //print("event.currentTarget: " + event.currentTarget);
            GradientSync.broadcaster = event.origin as? IGradientInput
            GradientSync.receiver!.setGradient(event.gradient!)
            GradientSync.receiver!.onEvent(GradientInputEvent(.Change,event.origin))//<--Not sure why you cant just forward the event as is!?
        }
    }
    /**
     * NOTE: this sets the gradient of the broadcaster not the receiver
     * NOTE: use the GradientSync.onGradientChange(GradientInputEvent(.change,self)) if you want to update the receiver
     */
    class func setGradient(gradient:IGradient) {
        if (GradientSync.broadcaster != nil) {GradientSync.broadcaster!.setGradient(gradient)}
    }
}