import Cocoa
@testable import Utils

extension Elastic5 where Self:FastListable5/*, Self:Scrollable5 */{
    /**
     * Elastic + Fast needs this method
     * PARAM value: is the final y value for the lableContainer
     * ⚠️️ Do not use scalar value here (0-1) well you know...
     */
    func setProgressVal(_ value:CGFloat,_ dir:Dir){//TODO: bind to Elastic and fast somehow
//        Swift.print("setProgressVal")
        //Swift.print("value: " + "\(value)")
        var progressValue:CGFloat?//new
        let contentSide:CGFloat = contentSize[dir]//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if contentSide < maskSize[dir] {//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / maskSize[dir]
            let val = progressValue! * maskSize[dir]
            posContainer(rbContainer,dir,val)
        }else{
            progressValue = value / -(contentSide - maskSize[dir])/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            (self as Progressable5).setProgress(progress,dir)/*moves the lableContainer up and down*/
//            Swift.print("progress: " + "\(progress)")
            (self as FastListable5).setProgress(progress)/*Updates the positions of the FastListItems*/
            //
            let sliderProgress = ElasticUtils.progress(value,contentSide,maskSize[dir])//doing some double calculations here
            /*finds the values that is outside 0 and 1*/
            if sliderProgress < 0 {//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let v1 = maskSize[dir] * -sliderProgress
                posContainer(rbContainer,dir,v1)/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if sliderProgress > 1 {
                let v2 = maskSize[dir] * -(sliderProgress-1)
                posContainer(rbContainer,dir,v2)
            }else{
                posContainer(rbContainer,dir,0)/*default position*/
            }
        }
        //Swift.print("rbContainer!.point[dir]: " + "\(rbContainer!.point[dir])")
        //Swift.print("contentContainer.point[dir]: " + "\(contentContainer!.point[dir])")
    }
}


//extension ElasticScrollableFastListable3{
//    func posContainer(_ rbContainer:Container,_ dir:Dir,_ value:CGFloat){/*Temp*/
//        disableAnim {rbContainer.layerPos(value,dir)}/*default position*/
//    }
//}
