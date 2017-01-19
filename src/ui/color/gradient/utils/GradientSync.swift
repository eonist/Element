import Cocoa
@testable import Utils

class GradientSync {
    static var receiver:IGradientInput?//this should be only settable from outside not gettable
    static var broadcaster:IGradientInput?//this should be only settable from outside not gettable
    static func onGradientChange(_ event:GradientInputEvent){
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
     * NOTE: This sets the gradient of the broadcaster not the receiver
     * NOTE: Use the GradientSync.onGradientChange(GradientInputEvent(.change,self)) if you want to update the receiver
     */
    static func setGradient(_ gradient:IGradient) {
        if (GradientSync.broadcaster != nil) {GradientSync.broadcaster!.setGradient(gradient)}
    }
}
