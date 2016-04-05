import Cocoa
/**
 * @example see TestCheckBoxButton
 * @Note: Remember to use the setChecked(true) if you want to change the state and skin after initiating the instance, since it wont do this itself on initiate
 */
class SelectCheckBoxButton:CheckBoxButton,ISelectable {
    private var isSelected:Bool
    init(_ width:CGFloat, _ height:CGFloat,  _ text:String = "defaultText", _ isSelected : Bool = false, _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String = ""){
        self.isSelected = isSelected
        super.init(width, height, text, isChecked, parent, id)
    }
    override func mouseDown(event:MouseEvent) {
        self.isSelected = !self.isSelected;
        super.mouseDown(event)
        super.onEvent(SelectEvent(SelectEvent.select,self))/*bubbles:true because i.e: radioBulet may be added to RadioButton and radioButton needs to dispatch Select event if the SelectGroup is to work*/
    }
    /**
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(isSelected:Bool) {
        self.isSelected = isSelected;
        setSkinState(getSkinState());
    }
    func getSelected()->Bool{return isSelected}
    override func getSkinState() -> String {
        return self.isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
