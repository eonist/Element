import Foundation

class ElasticScrollList3:List3,ElasticScrollable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
}
