import Cocoa
@testable import Utils

protocol Elastic5:Progressable5 {
    var moverGroup:MoverGroup {get set}
    var rbContainer:Container {get}/*Needed for the overshot animation*/
}
extension Elastic5{
    /**
     * TODO: ⚠️️ Probably move movergroup out of protocol extension as you need to be able to override setProgress in subclasses and that isn't possible if it resides inside a protocol extension
     */
    var createMoverGroup:MoverGroup {
        let setProgress = { (_ value:CGFloat,_ dir:Dir) -> Void in
//            guard dir == .hor else {return}
            self.contentContainer.layer?.position[dir] = value
        }
        var group = MoverGroup(setProgress,self.maskSize,self.contentSize)
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
}
