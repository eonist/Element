import Cocoa
@testable import Utils

class SelectButton:Button,ISelectable {
    private var isSelected:Bool
    init(_ width: CGFloat, _ height: CGFloat, _ isSelected : Bool = false, _ parent: IElement? = nil, _ id: String? = nil) {
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    /**
     * Select state should only take place when there is a mouseUpInside event
     */
    override func mouseUpInside(_ event:MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)/*Forward the event*/
        super.onEvent(SelectEvent(SelectEvent.select,self/*,self*/))
    }
    /**
     * NOTE: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(_ isSelected:Bool){
        self.isSelected = isSelected
        setSkinState(getSkinState())
    }
    func getSelected()->Bool{return isSelected}
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState()
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
