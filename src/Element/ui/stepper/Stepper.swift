import Foundation
@testable import Utils

class Stepper:Element{
    lazy var plusButton:Button = {self.addSubView(Button(self.skinSize.h,self.skinSize.h,self,"plus"))}()
    lazy var minusButton:Button = {self.addSubView(Button(self.skinSize.h,self.skinSize.h,self, "minus"))}()
    override func resolveSkin() {
        super.resolveSkin()
        _ = plusButton/*Init the UI*/
        _ = minusButton/*Init the UI*/
    }
}
