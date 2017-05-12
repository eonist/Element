import Cocoa
@testable import Utils

class ElasticScrollView3:ContainerView3,ElasticScrollable3{
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("stackString: " + "\(ElementParser.stackString(self))")
    }
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
}
