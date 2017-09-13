import Cocoa
@testable import Utils

protocol Elastic5:Progressable5 {
    var moverGroup:MoverGroup {get set}
    var rbContainer:Container {get}/*Needed for the overshot animation*/
}
extension Elastic5{
    var moverGrp:MoverGroup {//TODO: 🏀 Rename to createMoverGroup
        var group = MoverGroup((self as Elastic5).setProgress2,self.maskSize,self.contentSize)
        group.event = (self as! EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
    var createRBContainer:Container {
        /*Swift.print("create rbContainer")*/
        let rbContainer = (self as! NSView).addSubView(Container.init(size: (self as! ElementKind).skinSize, id: "rb"))//⚠️️TODO: move to lazy var later
        rbContainer.addSubview(contentContainer)/*Adds content Container inside rbContainer*/
        //fatalError("the bellow must be fixed")
        Swift.print("ElasticScrollFastList3. the bellow must be fixed")
        //contentContainer.parent = rbContainer/*Set the correct parent*/
        return rbContainer
    }
    /**
     * PARAM: value: contentContainer x/y value
     */
    func setProgress2(_ value:CGFloat,_ dir:Dir){
        disableAnim {contentContainer.layer?.position[dir] = value}//⚠️️ no need to disable anim anymore, it's taken care of by InteractiveView
    }
    func setProgress2(_ point:CGPoint){
        disableAnim {contentContainer.layer?.position = point}//⚠️️ no need to disable anim anymore, it's taken care of by InteractiveView
    }
    func posContainer(_ rbContainer:Container,_ dir:Dir,_ value:CGFloat){/*Temp*/
        disableAnim {rbContainer.layerPos(value,dir)}/*default position*///⚠️️ no need to disable anim anymore, it's taken care of by InteractiveView
    }
}
