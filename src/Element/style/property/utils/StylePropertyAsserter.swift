import Foundation
@testable import Utils

class StylePropertyAsserter {
    /**
     * Test if fillet is nil instead, 0 should return true actually. Think over state vs idle state etc
     */
    static func hasFillet(_ skin:ISkin,_ depth:Int = 0)->Bool {
        let fillet:Fillet = StylePropertyParser.fillet(skin,depth)
        return !(fillet.topLeft == 0 && fillet.topRight == 0 && fillet.bottomLeft == 0 && fillet.bottomRight == 0)
    }
    static func hasGradient(_ skin:ISkin,_ depth:Int = 0)->Bool {
        let value = StylePropertyParser.value(skin, CSSConstants.fill,depth)
        return value is Gradient/*|| StylePropertyParser.value(skin, "line", depth) is Gradient*/
    }
    static func hasAsset(_ skin:ISkin,_ depth:Int = 0)->Bool {
        return StylePropertyParser.value(skin, CSSConstants.fill,depth) is [Any]
    }
    static func hasDropShadow(_ skin:ISkin,_ depth:Int = 0)->Bool {
        let value = StylePropertyParser.value(skin, CSSConstants.drop_shadow,depth)
        /*You may need to do something like this: getGraphic().fillStyle.dynamicType is GradientFillStyle.Type*/
        return value != nil/*this differes slightly from the original code, but was needed to support "none" as a dropshadow param in css*/
    }
}
