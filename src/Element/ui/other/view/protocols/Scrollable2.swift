import Foundation

protocol Scrollable2:Displacable2{
    func onScrollWheelChange(_ event:String)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}
