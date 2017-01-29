import Foundation
@testable import Utils

//Continue here: 
    //add the third layer with the same style as SwitchThumb
    //try to move it onMouseMove
    //keep adding interaction + anim code from Switch1

class Switch2:SwitchSlider,ICheckable{
    private var isChecked:Bool
    init(_ width:CGFloat, _ height:CGFloat, _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String? = nil, _ classId:String? = nil) {
        self.isChecked = isChecked
        super.init(width,height,isChecked ? 1:0,parent,id)
    }
    override func mouseDown(_ event:MouseEvent) {
        Swift.print("Switch2.mouseDown")
        super.mouseDown(event)
    }
    override func mouseUpInside(_ event: MouseEvent) {
        Swift.print("Switch2.mouseUpInside")
        super.mouseUpInside(event)
    }
    override func mouseUpOutside(_ event: MouseEvent) {
        Swift.print("Switch2.mouseUpOutside")
        super.mouseUpOutside(event)
    }
    func setChecked(_ isChecked:Bool) {
        Swift.print("setChecked: " + "\(isChecked)")
        self.isChecked = isChecked
        setSkinState(getSkinState())
    }
    override func getClassType() -> String {
        return "\(Switch.self)"
    }
    func getChecked() -> Bool {
        return isChecked
    }
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState()
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
