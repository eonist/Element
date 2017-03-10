import Foundation

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    func scroll(_ event: String) {
        if(event == "exit"){
            hideSlider()
        }else if(event == "enter"){
            showSlider()
        }
        (self as Scrollable2).scroll(event)//protocol ambiguity
    }
}
