import Foundation
/**
 * @Note: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 */
class CheckButton :Button{
    var isChecked:Bool;
    init(_ width:CGFloat, _ height:CGFloat, _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String? = nil){
        self.isChecked = isChecked
        super.init(width,height,parent,id);
    }
    
    override func mouseUpInside(event: MouseEvent) {
        isChecked = !isChecked
        super.mouseUpInside(event)
        //onEvent(CheckEvent(CheckEvent.check, isChecked, self))
    }
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
