import Cocoa
@testable import Utils
//TODO: ⚠️️ do selected and _selected
class SelectButton:Button,Selectable {
    private var isSelected:Bool
    init(isSelected : Bool = false ,size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.isSelected = isSelected
        super.init(size: size, id: id)
    }
    /**
     * Select state should only take place when there is a mouseUpInside event
     */
    override func mouseUpInside(_ event:MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)/*Forward the event*/
        super.onEvent(SelectEvent(SelectEvent.select,self))
    }
    /**
     * NOTE: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(_ isSelected:Bool){
        self.isSelected = isSelected
        self.skinState = {self.skinState}()
    }
    func getSelected()->Bool{return isSelected}
    override var skinState:String {
        get {return self.isSelected ? SkinStates.selected + " " + super.skinState : super.skinState}
        set {super.skinState = newValue}
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //dep
    init(_ width: CGFloat, _ height: CGFloat, _ isSelected : Bool = false, _ parent: ElementKind? = nil, _ id: String? = nil) {
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
}
