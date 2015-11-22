import Foundation

class TextButton:Button {
    init(_ title:String = "", _ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil) {
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
