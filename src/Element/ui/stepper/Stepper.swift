import Foundation
@testable import Utils

class Stepper:Element{
    lazy var plusButton:Button = {self.addSubView(Button(self.height,self.height,self,"plus"))}()
    lazy var minusButton:Button = {self.addSubView(Button(self.height,self.height,self, "minus"))}()
    override func resolveSkin() {
        super.resolveSkin()
        _ = plusButton/*Init the UI*/
        _ = minusButton/*Init the UI*/
    }
}
