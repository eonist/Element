import Foundation

protocol ElasticScrollable2:Elastic2,Scrollable2{}

extension ElasticScrollable2{
    func onScrollWheelEnter() {
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
    }
    func onScrollWheelExit() {
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
    }
    func onScrollWheelChange(_ event: String) {
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event)")
    }
}
