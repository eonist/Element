import Foundation
import Cocoa
/**
 * NOTE: Container does not add the skin to the stage, Use Section if you need a skin added to
 * // :TODO: rename to Div,Division,Section,Segment? or? Div sounds best and is closley related to css
 */
class Container:FlippedView{
    init(_ width:Int = 100, _ height:Int = 100) {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
    /**
     * Returns "Container"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    func getClassType()->String{
        return String(self.dynamicType)
    }
}