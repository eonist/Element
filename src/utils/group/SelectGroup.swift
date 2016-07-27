import Cocoa
/**
 * NOTE: this class also works great with RadioBullets
 * NOTE: Remember to add the selectGroup instance to the view so that the event works correctly // :TODO: this is a bug try to fix it
 * NOTE: Use the SelectGroupModifier and SelectGroupParser for Modifing and parsing the SelectGroup
 * TODO: You could add a SelectGroupExtension class that adds Modifing and parsing methods to the SelectGroup instance!
 * EXAMPLE: (IMPORTANT: We use the EventLib instead now)
 * let radioButtonGroup = RadioButtonGroup([rb1,rb2, rb3]);
 * NSNotificationCenter.defaultCenter().addObserver(radioButtonGroup, selector: "onSelect:", name: SelectGroupEvent.select, object: radioButtonGroup)
 * func onSelect(sender: AnyObject) { Swift.print("Event: " + ((sender as! NSNotification).object as ISelectable).isSelected}
 */

class SelectGroup:EventSender{
    var selectables:Array<ISelectable> = []
    private var selected:ISelectable?
    init(_ selectables:Array<ISelectable>, _ selected:ISelectable? = nil){
        super.init()
        self.selected = selected
        addSelectables(selectables)
    }
    func addSelectables(selectables:Array<ISelectable>){
        //Swift.print("SelectGroup.addSelectables()")
        for item : ISelectable in selectables {addSelectable(item)}
    }
    /**
     * @Note use a weak ref so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addSelectable(selectable:ISelectable) {
        //Swift.print("SelectGroup.addSelectable()")
        //let anyObj:AnyObject = selectable
        
        if(selectable is IEventSender){
            (selectable as! IEventSender).event = onEvent
        }
        selectables.append(selectable);
    }
    override func onEvent(event:Event){
        if(event.type == SelectEvent.select){
            Swift.print("SelectGroup.onEvent()")
            //Swift.print("SelectGroup.onEvent() immediate: " + "\(event.immediate)")
            self.event!(SelectGroupEvent(SelectGroupEvent.select,selected,self/*,self*/))
            selected = event.immediate as? ISelectable
            Swift.print("selected: " + "\(selected)")
            Swift.print("selectables.count: " + "\(selectables.count)")
            
            SelectModifier.unSelectAllExcept(selected!, selectables)
            for s in selectables{
                Swift.print("s.isSelected: " + "\(s.getSelected())")
            }
            super.onEvent(SelectGroupEvent(SelectGroupEvent.change,selected,self/*,self*/))
        }
        super.onEvent(event)//we dont want to block any event being passed through, so we forward all events right through the SelectGroup
    }
    //@objc func onButtonDown(sender: AnyObject) {
        //Swift.print("SelectGroup.onButtonDown() ")
        //let textButton:TextButton = (sender as! NSNotification).object as! TextButton
        /*if(textButton === self.textButton!){
        Swift.print("sender.object === self.textButton")
        }*/
        
        /*
        Swift.print("object: " + String((sender as! NSNotification).object))
        Swift.print("name: " + String((sender as! NSNotification).name))//buttonEventDown
        Swift.print("userInfo: " + String((sender as! NSNotification).userInfo))//nil
        */
        //Swift.print("WinView.onButtonDown() Sender: " + String(sender))
    //}
}