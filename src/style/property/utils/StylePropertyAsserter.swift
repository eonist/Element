import Foundation

class StylePropertyAsserter {
    /**
     * Test if fillet is nil instead, 0 should return true actually. Think over state vs idle state etc
     */
    static func hasFillet(skin:ISkin,_ depth:Int = 0)->Bool {
        let fillet:Fillet = StylePropertyParser.fillet(skin,depth);
        //Swift.print("StylePropertyAsserter.hasFillet() " + String(fillet))
        //Swift.print(fillet.topLeft)
        //Swift.print(fillet.topRight)
        return !(fillet.topLeft == 0 && fillet.topRight == 0 && fillet.bottomLeft == 0 && fillet.bottomRight == 0)
    }
    static func hasGradient(skin:ISkin,_ depth:Int = 0)->Bool {
        let value = StylePropertyParser.value(skin, CSSConstants.fill,depth)
        //you may need to do something like this: getGraphic().fillStyle.dynamicType is GradientFillStyle.Type
        let hasGradient = value is Gradient
        return hasGradient /*|| StylePropertyParser.value(skin, "line", depth) is Gradient*/
        //return false
    }
    static func hasAsset(skin:ISkin,_ depth:Int = 0)->Bool {
        return StylePropertyParser.value(skin, CSSConstants.fill,depth) is Array<Any>
    }
    static func hasDropShadow(skin:ISkin,_ depth:Int = 0)->Bool {
        let value = StylePropertyParser.value(skin, CSSConstants.drop_shadow,depth)
        //Swift.print("StylePropertyAsserter.hasDropShadow() value: " + String(value))
        /*you may need to do something like this: getGraphic().fillStyle.dynamicType is GradientFillStyle.Type*/
        let hasDropShadow = value != nil/*this differes slightly from the original code, but was needed to support "none" as a dropshadow param in css*/
        //Swift.print("hasDropShadow: " + "\(hasDropShadow)")
        return hasDropShadow
    }
}