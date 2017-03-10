import Foundation

protocol Scrollable2:Displacable2{
    func onScrollWheelChange(_ event:String)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}


extension Scrollable2{
    /**
     * IMPORTANT: as long as this method doesnt recide in the baseClass it can be reached with protocol ambiguity
     */
    func scroll(_ event:String){//from scrollWheel
        if(event == "change"){
            onScrollWheelChange(event)
        }else if(event == "enter"){
            onScrollWheelEnter()
        }else if(event == "exit"){
            onScrollWheelExit()
        }
    }
    func onScrollWheelChange(_ event:String) {
        Swift.print("📜 Scrollable.onScrollWheelChange: \(event)")
        setProgress(0.5)/*<-faux progress, its caluclated via delta noramlly*/
    }
    /*func setProgress(_ progress:CGFloat){
     Swift.print("📜 Scrollable.setProgress(\(progress)) move the lableContainer.y up and down")
     }*/
    func onScrollWheelEnter() {
        Swift.print("📜 Scrollable.onScrollWheelEnter")
    }
    func onScrollWheelExit() {
        Swift.print("📜 Scrollable.onScrollWheelExit")
    }
}
