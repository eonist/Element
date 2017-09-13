import Foundation
@testable import Utils

class ElasticScrollFastList3:FastList3,ElasticScrollableFastListable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgressVal,self.maskSize,self.contentSize)
    lazy var rbContainer:Container? = {return self.rubberBandContainer}()/*needed for the overshot animation*/
}
extension Elastic3 where Self:FastList3{
    var rubberBandContainer:Container {
        /*Swift.print("create rbContainer")*/
        let rbContainer = addSubView(Container(self.skinSize.w,self.skinSize.h,self,"rb"))//⚠️️TODO: move to lazy var later
        rbContainer.addSubview(contentContainer)/*Adds content Container inside rbContainer*/
//        fatalError("the bellow must be fixed")
        Swift.print("ElasticScrollFastList3. the bellow must be fixed")
        //contentContainer.parent = rbContainer/*Set the correct parent*/
        return rbContainer
    }
}
