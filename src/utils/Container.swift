import Foundation
import Cocoa
/**
 * NOTE: Container does not add the skin to the stage, Use Section if you need a skin added to
 * TODO: rename to Div,Division,Section,Segment? or? Div sounds best and is closley related to css, too closley reletate. Container is a good name!
 */
class Container:Element{
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)/*We still need to generate the skin, why? I can't recall*/
    }
}