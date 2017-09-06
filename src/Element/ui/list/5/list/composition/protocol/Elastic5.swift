import Cocoa
@testable import Utils

protocol Elastic5:Progressable5 {
    var moverGroup:MoverGroup {get}
    var rbContainer:Container {get}/*Needed for the overshot animation*/
}
extension Elastic5{
    var moverGrp:MoverGroup {//TODO: 🏀 Rename to createMoverGroup
        var group = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
        group.event = (self as! EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
    func posContainer(_ rbContainer:Container,_ dir:Dir,_ value:CGFloat){/*Temp*/
        disableAnim {rbContainer.layerPos(value,dir)}/*default position*/
    }
    var rubberBandContainer:Container {
        /*Swift.print("create rbContainer")*/
        let rbContainer = (self as! NSView).addSubView(Container.init(size: (self as! ElementKind).skinSize, id: "rb"))//⚠️️TODO: move to lazy var later
        rbContainer.addSubview(contentContainer)/*Adds content Container inside rbContainer*/
        //        fatalError("the bellow must be fixed")
        Swift.print("ElasticScrollFastList3. the bellow must be fixed")
        //contentContainer.parent = rbContainer/*Set the correct parent*/
        return rbContainer
    }
}