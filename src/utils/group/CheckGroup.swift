import Foundation
/*
 * @Note: remeber to add the group to the view or else the eventBubbling may make errors in other components
 * @Note: this class would be more logical if it extended EventSender but it extends View so that the event bubbling on the ICheckable objects works
 * @Note: the constructor checked parameter is just a reference no action is applied to that checked item.
 * // :TODO: In the future make a MultipleSelectionCheckGroup that can select many icheckable items with the use of shift key for instance (do not add this functionality in this class its not the correct abstraction level)
 * // :TODO: fix the bubbling stuff this should need to be added to the view or be a sprite.
 */
class CheckGroup:EventSender {
    var checkables:Array<ICheckable> = []
    var checked:ICheckable?
    init(_ checkables:Array<ICheckable>, _ checked:ICheckable? = nil){
        super.init()
        addCheckables(checkables)
        self.checked = checked!
    }
    func onCheck(event:Event) {// :TODO: make protected see SelectGroup
        Swift.print("CheckGroup.onCheck() origin: " + "\(event.origin)" + " type: " + "\(event.type)")
        if(event.type == CheckEvent.check){
            self.event!(CheckGroupEvent(CheckGroupEvent.check,self,checked))
            checked = event.origin as? ICheckable
            //SelectModifier.unSelectAllExcept(selected!, checkables);
            CheckModifier.unCheckAllExcept(checked!, checkables)
            self.event!(CheckGroupEvent(CheckGroupEvent.change,self,checked))
            
        }
        //print("CheckGroup.onCheck: " + event);
    }
    func addCheckables(checkables:Array<ICheckable>) {
        for checkable : ICheckable in checkables{ addCheckable(checkable)}
    }
    /**
     * @Note use a weak ref so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addCheckable(checkable:ICheckable) {
        if(checkable is IEventSender){(checkable as! IEventSender).event = onCheck}
        checkables.append(checkable);
    }
}