import Cocoa


class SelectButton:Button,ISelectable {
    var isSelected:Bool
    init(_ width: CGFloat, _ height: CGFloat, _ isSelected : Bool = false, _ parent: IElement?, _ id: String?) {
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func mouseUpInside(theEvent: NSEvent) {
        isSelected = true
        super.mouseUpInside(theEvent)
        NSNotificationCenter.defaultCenter().postNotificationName(ButtonEvent.releaseInside, object:self)
        
        
        dispatchEvent(new SelectEvent(SelectEvent.SELECT,_isSelected,true,true));/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
    }
    
    func setSelected(isSelected:Bool){
        self.isSelected = isSelected
    }
    func selected()->Bool{
        return isSelected
    }
}
