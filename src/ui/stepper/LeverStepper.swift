import Foundation
/**
 * // :TODO: shouldnt this class extend Stepper?
 */
class LeverStepper : Element{
    var plusButton:Button?
    var minusButton:Button?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        plusButton = addSubView(Button(height,height,self,"plus")) as? Button;
        minusButton = addSubView(Button(height,height,self, "minus")) as? Button;
    }
    /**
     * Returns "Stepper"
     * @Note This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return String(Stepper)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
