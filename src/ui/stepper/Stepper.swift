import Foundation

class Stepper : Element{
    var plusButton:Button?
    var minusButton:Button?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String?) {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        plusButton = addSubView(Button(height,height,self,"plus"))
        minusButton = addSubView(Button(height,height,self, "minus"))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}