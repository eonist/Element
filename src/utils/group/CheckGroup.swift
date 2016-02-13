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
    init(checkables:Array<ICheckable>, checked:ICheckable? = nil){
        addCheckables(checkables)
        self.checked = checked!
    }
    func onCheck(event:Event) {// :TODO: make protected see SelectGroup
        if(event.type == SelectEvent.select){
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
        if(checkable is IEventSender){
            (checkable as! IEventSender).event = onCheck
        }
        checkables.append(checkable);
    }
    /**
     * Removes the RadioButton passed through the @param radioButton
     */
    func removeCheckable(item:ICheckable)->ICheckable? {
        for (var i:Int=0; i < checkables.count; i++) {
            if (checkables[i] === item) {
                return checkables.splice (i,1);	// :TODO: dispatch something?
            }
        }
        return nil;
    }
    /**
     * Returns an ICheckable at a spessific index
     */
    func getCheckableAt(index:Int)->ICheckable? {// :TODO: consider moving in to util class or just write it up as a note
        if(index <= checkables.count) {return checkables[index]}
        else {fatalError("\(self)" + " no ISelectable at the index of: " + "\(index)")}
        return nil
    }
    /**
     * Returns the RadioButton index passed through the @param item
     */
    func itemToIndex(item:AnyObject)->Int{// :TODO: move to utils class see SelectGroup
        return checkables.indexOf(item);
    }
}