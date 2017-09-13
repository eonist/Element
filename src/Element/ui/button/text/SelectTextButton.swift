import Cocoa
@testable import Utils
/**
 * NOTE: Maybe the methods relating to ISelectable could be moved to an extension (Maybe not, since you need access to super, test this idea in playground)
 */
class SelectTextButton:TextButton,Selectable {
    var isSelected:Bool
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isSelected:Bool = false, _ parent:ElementKind? = nil, _ id:String? = nil){
        self.isSelected = isSelected
        super.init(width, height, text, parent, id)
    }
    override func mouseUpInside(_ event: MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)
        self.event(SelectEvent(SelectEvent.select,self))
    }
    /**
     * NOTE: Do not add a dispatch event here, that is the responsibility of the caller
     */
    func setSelected(_ isSelected:Bool){
        self.isSelected = isSelected
        skinState = {self.skinState}()
    }
    func getSelected()->Bool{return isSelected}
    override var skinState:String {
        get {return isSelected ? SkinStates.selected + " " + super.skinState : super.skinState}
        set {super.skinState = newValue}
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
