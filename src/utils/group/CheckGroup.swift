import Foundation
/*
 * NOTE: remeber to add the group to the view or else the eventBubbling may make errors in other components
 * NOTE: this class would be more logical if it extended EventSender but it extends View so that the event bubbling on the ICheckable objects works
 * NOTE: the constructor checked parameter is just a reference no action is applied to that checked item.
 * TODO: In the future make a MultipleSelectionCheckGroup that can select many icheckable items with the use of shift key for instance (do not add this functionality in this class its not the correct abstraction level)
 * TODO: fix the bubbling stuff this should need to be added to the view or be a sprite.
 */
class CheckGroup:EventSender {
    var checkables:Array<ICheckable> = []
    var checked:ICheckable?
    init(_ checkables:Array<ICheckable>, _ checked:ICheckable? = nil){
        super.init()
        addCheckables(checkables)
        self.checked = checked!
    }
    func addCheckables(checkables:Array<ICheckable>) {
        for checkable : ICheckable in checkables{ addCheckable(checkable)}
    }
    /**
     * NOTE: use a weak ref so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addCheckable(checkable:ICheckable) {
        if(checkable is IEventSender){(checkable as! IEventSender).event = onEvent}
        checkables.append(checkable);
    }
    override func onEvent(event:Event) {// :TODO: make protected see SelectGroup
        if(event.type == CheckEvent.check){
            Swift.print("CheckGroup.onEvent() immediate: " + "\(event.immediate)" + " type: " + "\(event.type)")
            self.event!(CheckGroupEvent(CheckGroupEvent.check,checked,self/*,self*/))
            checked = event.immediate as? ICheckable
            //SelectModifier.unSelectAllExcept(selected!, checkables)
            CheckModifier.unCheckAllExcept(checked!, checkables)
            super.onEvent(CheckGroupEvent(CheckGroupEvent.change,checked,self/*,self*/))
            
        }
        //print("CheckGroup.onCheck: " + event)
    }
}