import Foundation
import Cocoa
/**
 * NOTE: Container does not add the skin to the stage, Use Section if you need a skin added to
 * // :TODO: rename to Div,Division,Section,Segment? or? Div sounds best and is closley related to css
 */
class Container:Element{
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = nil){
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)/*We still need to generate the skin, why? I can't recall*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
    /**
     * Returns "Container"
     * @Note This function is used to find the correct class type when synthezing the element cascade
     */
    override func getClassType()->String{
        return String(Container)
    }
}