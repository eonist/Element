import Foundation

protocol Scrollable2:Displacable2{
    func onScrollWheelChange(_ event:String)
    func onScrollWheelEnter()
    func onScrollWheelExit()
}

extension Scrollable2{
    var interval:CGFloat{return floor(itemsHeight - height)/itemHeight}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
    var progress:CGFloat{return SliderParser.progress(lableContainer!.y, height, itemsHeight)}
    /**
     * IMPORTANT: as long as this method doesnt recide in the baseClass it can be reached with protocol ambiguity
     */
    func scroll(_ event:NSEvent){//from scrollWheel
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
