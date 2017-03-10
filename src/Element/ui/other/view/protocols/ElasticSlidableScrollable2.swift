import Cocoa

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    func scroll(_ event: NSEvent) {
        if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
            hideSlider()
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        (self as Scrollable2).scroll(event)//👈 this shouldn't work! protocol ambiguity, code reuse across inheritance, shared inheritance
    }
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
