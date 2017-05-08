import Foundation
@testable import Utils

class Stepper:Element{
    lazy var plusButton:Button = {self.addSubView(Button(self.height,self.height,self,"plus"))}()
    lazy var minusButton:Button = {self.addSubView(Button(self.height,self.height,self, "minus"))}()
}
