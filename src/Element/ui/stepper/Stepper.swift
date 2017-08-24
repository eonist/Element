import Foundation
@testable import Utils

class Stepper:Element{
    lazy var plusButton:Button = createPlusButton()
    lazy var minusButton:Button = createMinusButton()
    override func resolveSkin() {
        super.resolveSkin()
        _ = plusButton/*Init the UI*/
        _ = minusButton/*Init the UI*/
    }
}
extension Stepper{
    func createPlusButton() -> Button{
        return self.addSubView(Button(self.skinSize.h,self.skinSize.h,self,"plus"))
    }
    func createMinusButton() -> Button{
        return self.addSubView(Button(self.skinSize.h,self.skinSize.h,self, "minus"))
    }
}
