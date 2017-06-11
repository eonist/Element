import Foundation
@testable import Utils

class ElasticScrollFastList3:FastList3,ElasticScrollableFastListable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgressVal,self.maskSize,self.contentSize)
    lazy var rbContainer:Container? = {return self.rubberBandContainer}()/*needed for the overshot animation*/
}
extension Elastic3 where Self:FastList3{
    var rubberBandContainer:Container {
        /*Swift.print("create rbContainer")*/
        let rbContainer = addSubView(Container(self.width,self.height,self,"rb"))//⚠️️TODO: move to lazy var later
        rbContainer.addSubview(contentContainer)/*adds content Container inside rbContainer*/
        contentContainer.parent = rbContainer/*set the correct parent*/
        return rbContainer
    }
}
