import Cocoa
@testable import Utils
@testable import Element

class IterimScrollGroup{//rename to interim*
    var iterimScrollX:InterimScroll = InterimScroll()
    var iterimScrollY:InterimScroll = InterimScroll()
}
extension IterimScrollGroup{
    func iterimScroll(_ dir:Dir)-> InterimScroll{/*Convenience*/
        return dir == .hor ? iterimScrollX : iterimScrollY
    }
    var prevScrollingDelta:CGFloat {
        get{fatalError("get not supported")}
        set{iterimScrollX.prevScrollingDelta = newValue;iterimScrollY.prevScrollingDelta = newValue}
    }
    var velocities:[CGPoint]{
        get{return zip(iterimScrollX.velocities,iterimScrollY.velocities).map{CGPoint($0.0,$0.1)}}
        set{iterimScrollX.velocities = newValue.map{$0.x};iterimScrollY.velocities = newValue.map{$0.y}}
    }
    func setPrevDelta(_ event:NSEvent){
        iterimScroll(.hor).prevScrollingDelta = event.scrollingDelta[.hor]/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        iterimScroll(.ver).prevScrollingDelta = event.scrollingDelta[.ver]
    }
    func shiftAppend(_ event:NSEvent){
        _ = iterimScroll(.hor).velocities.shiftAppend(event.scrollingDelta[.hor])/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        _ = iterimScroll(.ver).velocities.shiftAppend(event.scrollingDelta[.ver])
    }
}
