import Cocoa
@testable import Utils
/**
 * EXAMPLE: see TestCheckBoxButton
 * NOTE: Remember to use the setChecked(true) if you want to change the state and skin after initiating the instance, since it wont do this itself on initiate
 */
class SelectCheckBoxButton:CheckBoxButton,Selectable {
    private var isSelected:Bool
    init(_ width:CGFloat, _ height:CGFloat,  _ text:String = "defaultText", _ isSelected : Bool = false, _ isChecked:Bool = false, _ parent:ElementKind? = nil, _ id:String = ""){
        self.isSelected = isSelected
        super.init(width, height, text, isChecked, parent, id)
    }
    override func mouseDown(_ event:MouseEvent) {
        self.isSelected = !self.isSelected
        super.mouseDown(event)
        super.onEvent(SelectEvent(SelectEvent.select,self))
    }
    /**
     * NOTE: Do not add a dispatch event here, that is the responsibily of the caller
     */
    func setSelected(_ isSelected:Bool) {
        self.isSelected = isSelected
        setSkinState(getSkinState())
    }
    func getSelected()->Bool{return isSelected}
    override func getSkinState() -> String {
        return self.isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState()
    }
    required init(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
