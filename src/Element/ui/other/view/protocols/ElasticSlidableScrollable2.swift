import Cocoa

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    func scroll(_ event: NSEvent) {
        if(event.phase == NSEventPhase.ended || NSEventPhase.cancelled){
            hideSlider()
        }else if(event == "enter"){
            showSlider()
        }
        (self as Scrollable2).scroll(event)//👈 this shouldnt work! protocol ambiguity, code reuse across inheritance, shared inheritance
    }
}
switch {
case NSEventPhase.changed:onScrollWheelChange(theEvent)/*Fires everytime there is direct scrollWheel gesture movment.*/
case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
case NSEventPhase.ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
case NSEventPhase.cancelled:onScrollWheelExit();
/*
 extension Slidable where Self:ElasticScrollable{
 func scroll(_ event: String) {
 if(event == "change"){
 print("🏂")
 }
 (self as Scrollable).scroll(event)
 }
 }*/
