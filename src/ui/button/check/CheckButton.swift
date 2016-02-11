import Foundation
/**
 * @Note: to force the CheckButton to apply its Checked or unchecked skin, use the setChecked after the instance is created
 */
class CheckButton :Button{
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        super.init(width,height,parent,id);
    }
    
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
