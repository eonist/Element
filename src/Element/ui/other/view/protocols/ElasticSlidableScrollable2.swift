import Foundation

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    func scroll(_ event: String) {
        if(event == "exit"){
            hideSlider()
        }else if(event == "enter"){
            showSlider()
        }
        (self as Scrollable2).scroll(event)//protocol ambiguity, code reuse across inheritance, shared inheritance
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
 }*/
