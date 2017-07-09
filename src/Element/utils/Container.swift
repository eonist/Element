import Foundation
import Cocoa
@testable import Utils
/**
 * IMPORTANT: ⚠️️ Container does not add the skin to the stage, Use Section if you need a skin added to
 * TODO: Rename to Div,Division,Section,Segment? or? Div sounds best and is closley related to css, too closley reletate. Container is a good name!
 * IMPRTANT: ⚠️️ May have probs with interactions like scrollWhell. use Section instead, which has a background
 */
class Container:Element{
    override func resolveSkin() {
        skin = SkinResolver.skin(self)/*We still need to generate the skin, why? I can't recall*/   
    }
    /**
     * New
     * Temp solution, until we figure out a better way to toggle major direction etc. 
     */
    func layerPos(_ val:CGFloat,_ dir:Dir){
        if dir == .ver {
            self.layer?.position[dir] = val
        }
    }
}
