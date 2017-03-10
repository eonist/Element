import Cocoa

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    /**
     *
     */
    func setProgress(_ value: CGFloat) {//<-directtransmission value 💥
        (self as Elastic2).setProgress(value)
        slider!.setProgressValue(progress)//<- scalar value 0-1
    }
    /**
     * ⚠️️⚠️️⚠️️SUPER IMPORTANT CONCEPT⚠️️⚠️️⚠️️: methods that are called from shallow can overide downstream
     */
    func scroll(_ event: NSEvent) {
        Swift.print("👻🏂📜 ElasticSlidableScrollable2.scroll()")
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
