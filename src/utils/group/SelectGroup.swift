import Cocoa
/**
 * EXAMPLE:
 * let radioButtonGroup = RadioButtonGroup([rb1,rb2, rb3]);
 * NSNotificationCenter.defaultCenter().addObserver(radioButtonGroup, selector: "onSelect:", name: SelectGroupEvent.select, object: radioButtonGroup)
 * func onSelect(sender: AnyObject) { Swift.print("Event: " + ((sender as! NSNotification).object as ISelectable).isSelected}
 */
class SelectGroup{
    private var selectables:Array<ISelectable> = [];
    private var selected:ISelectable?;
    init(_ selectables:Array<ISelectable>, _ selected:ISelectable? = nil){
        addSelectables(selectables);
        self.selected = selected
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSelectables(selectables:Array<ISelectable>){
        Swift.print("SelectGroup.addSelectables()")
        for item : ISelectable in selectables {addSelectable(item)}
    }
    /**
     * @Note useWeakReference is set to true so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addSelectable(selectable:ISelectable) {
        Swift.print("SelectGroup.addSelectable()")
        //let anyObj:AnyObject = selectable
        
        
        //Continue here: try to send Notifications from one class to another in playground. make an example
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: selectable as! SelectButton)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSelect:", name: SelectEvent.select, object: selectable as! SelectButton)
        selectables.append(selectable);
    }
    func onSelect(sender: AnyObject) {// :TODO: make this as protected since you may want to impose different functionaly when clicked, like multi select etc
        Swift.print("SelectGroup.onSelect(): " + String(sender))
        NSNotificationCenter.defaultCenter().postNotificationName(SelectGroupEvent.select, object:selected)/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
        selected = (sender as! NSNotification).object as? ISelectable
        SelectModifier.unSelectAllExcept(selected!, selectables);
        NSNotificationCenter.defaultCenter().postNotificationName(SelectGroupEvent.change, object:selected)
    }
    func onButtonDown(sender: AnyObject) {
        Swift.print("SelectGroup.onButtonDown() ")
        //let textButton:TextButton = (sender as! NSNotification).object as! TextButton
        /*if(textButton === self.textButton!){
        Swift.print("sender.object === self.textButton")
        }*/
        
        
        Swift.print("object: " + String((sender as! NSNotification).object))
        Swift.print("name: " + String((sender as! NSNotification).name))//buttonEventDown
        Swift.print("userInfo: " + String((sender as! NSNotification).userInfo))//nil
        //Swift.print("WinView.onButtonDown() Sender: " + String(sender))
    }
}