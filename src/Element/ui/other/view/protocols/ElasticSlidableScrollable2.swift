import Cocoa
@testable import Utils

protocol ElasticSlidableScrollable2:ElasticScrollable2,Slidable2{}

extension ElasticSlidableScrollable2{
    /**
     * setProgress comes from shallow
     */
    func setProgress(_ value:CGFloat) {//<-direct transmission value 💥
        (self as Elastic2).setProgress(value)
        progressValue = ElasticUtils.progress(value,itemsHeight,height)
        slider!.setProgressValue(progressValue!)//<- scalar value 0-1
    }
    
    /**
     * ⚠️️⚠️️⚠️️SUPER IMPORTANT CONCEPT⚠️️⚠️️⚠️️: methods that are called from shallow can overide downstream
     */
    func scroll(_ event: NSEvent) {
        Swift.print("👻🏂📜 ElasticSlidableScrollable2.scroll()")
        (self as Scrollable2).scroll(event)//👈 calls from shallow can overide downstream
        /*the following must be after the call above or else the thumb is hidden because of anim.end*/
        if(event.phase == NSEventPhase.changed){
            if(mover!.isDirectlyManipulating){
                //also manipulates slider, but only on directTransmission, as mover calls setProgress from shallow in indirectTransmission
                setProgress(mover!.result)//👈NEW, this migth need to be inSide scrollWheel call, as it needs to be shallow to reach inside setProgress in ElasticFastList.setProgress, but maybe not, To be continued
            }
        }else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
            //hideSlider()
        }else if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
    }
    func scrollWheelExitedAndIsStationary() {
        Swift.print("👻🏂📜 ElasticSlidableScrollable2.scrollWheelExitedAndIsStationary()")
        hideSlider()
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
