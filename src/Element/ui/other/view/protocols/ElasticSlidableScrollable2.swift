import Cocoa

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    /**
     * ⚠️️⚠️️⚠️️SUPER IMPORTANT CONCEPT⚠️️⚠️️⚠️️: methods that are called from shallow can overide downstream
     */
    func scroll(_ event: NSEvent) {
        if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
            hideSlider()
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        (self as Scrollable2).scroll(event)//👈 calls from shallow can overide downstream
    }
    
    //TODO: some experimenting required when implementing setProgress
    
}
/*
extension Slidable where Self:ElasticScrollable{
    func scroll(_ event: String) {
        if(event == "change"){
            print("🏂")
        }
        (self as Scrollable).scroll(event)
    }
}
*/
