import Cocoa
/**
 * EXAMPLE:
 * let radioButtonGroup = RadioButtonGroup([rb1,rb2, rb3]);
 * NSNotificationCenter.defaultCenter().addObserver(radioButtonGroup, selector: "onSelect:", name: SelectGroupEvent.select, object: radioButtonGroup)
 * func onSelect(sender: AnyObject) { Swift.print("Event: " + ((sender as! NSNotification).object as ISelectable).isSelected}
 */
class SelectGroup : NSView{
    private var selectables:Array<ISelectable> = [];
    private var selected:ISelectable?;
    init(_ selectables:Array<ISelectable>, _ selected:ISelectable? = nil){
        self.selected = selected
        super.init(frame: NSRect(0,0,100,100))
        addSelectables(selectables);
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSelectables(selectables:Array<ISelectable>){
        for item : ISelectable in selectables {addSelectable(item)}
    }
    /**
     * @Note useWeakReference is set to true so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addSelectable(selectable:ISelectable) {
        let anyObj:AnyObject = selectable
        
        
        //Continue here: try to send Notifications from one class to another in playground. make an example
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSelect:", name: SelectEvent.select, object: anyObj)
        selectables.append(selectable);
    }
    func onSelect(sender: AnyObject) {// :TODO: make this as protected since you may want to impose different functionaly when clicked, like multi select etc
        Swift.print("SelectGroup.onSelect(): " + String(sender))
        NSNotificationCenter.defaultCenter().postNotificationName(SelectGroupEvent.select, object:selected)/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
        selected = (sender as! NSNotification).object as? ISelectable
        SelectModifier.unSelectAllExcept(selected!, selectables);
        NSNotificationCenter.defaultCenter().postNotificationName(SelectGroupEvent.change, object:selected)
    }
}