import Foundation

class SelectGroup {
    private var selectables:Array<ISelectable> = [];
    private var selected:ISelectable?;
    init(selectables:Array<ISelectable>, selected:ISelectable? = nil){
        addSelectables(selectables);
        self.selected = selected
    }
    func addSelectables(selectables:Array){
        for item : ISelectable in selectables {addSelectable(item)}
    }
    /**
     * @Note useWeakReference is set to true so that we dont have to remove the event if the selectable is removed from the SelectGroup or view
     */
    func addSelectable(selectable:ISelectable) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onButtonDown:", name: ButtonEvent.down, object: self)
        IEventDispatcher(selectable).addEventListener(SelectEvent.select, onSelect,false,0,true);
        _selectables.push(selectable);
    }
}
