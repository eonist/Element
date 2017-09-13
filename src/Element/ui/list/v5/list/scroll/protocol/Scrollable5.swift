import Cocoa

protocol Scrollable5:Progressable5{
//    func onScrollWheelChange(_ event:NSEvent)/*Fires onle while direct scroll, not momentum*/
//    func onScrollWheelEnter()/*fires while there still is momentum aka indirect scroll*/
//    func onScrollWheelExit()/*This happens after there has been panning and the touches release*/
//    func onScrollWheelCancelled()/*This happens when there has been no panning, just 2 finger touch and release with out moving around*/
//    func onInDirectScrollWheelChange(_ event:NSEvent)//rename to onScrollWheelMomentumChange
//    /*Momentum*/
//    func onScrollWheelMomentumEnded()
//    func onScrollWheelMomentumBegan(_ event:NSEvent)/*This happens right after touch release and there is enough velocity that momentum is engaged, we forward the event because we might need the scrollingDelta for velocity*/ 
}
