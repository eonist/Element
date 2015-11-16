import Foundation

class StylePropertyAsserter {
    class func hasFillet(skin:ISkin)->Bool {
        let fillet:Fillet = StylePropertyParser.fillet(skin);
        return !(fillet.topLeft == 0 && fillet.topRight == 0 && fillet.bottomLeft == 0 && fillet.bottomRight == 0);
    }
    class func hasGradient(skin:ISkin)->Bool {
        let value = StylePropertyParser.value(skin, CSSConstants.fill)
        let hasGradient = value is Gradient
        return hasGradient /*|| StylePropertyParser.value(skin, "line", depth) is Gradient*/;
        /**/
        //return false
    }
    class func hasAsset(skin:ISkin)->Bool {
        /*
        return StylePropertyParser.value(skin, CSSConstants.FILL, depth) is Array;
        */
        return false
    }
    class func hasDropShadow(skin:ISkin)->Bool {
        /*
        return StylePropertyParser.value(skin, CSSConstants.DROP_SHADOW, depth) is DropShadowFilter;
        */
        return false
    }
}