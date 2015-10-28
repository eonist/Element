import Foundation

class StylePropertyAsserter {
    class func hasFillet(style:IStyle)->Bool {
        /*
        var fillet:Fillet = StylePropertyParser.fillet(skin,depth);
        return !(fillet.topLeft == 0 && fillet.topRight == 0 && fillet.bottomLeft == 0 && fillet.bottomRight == 0);
        */
        return false
    }
    class func hasGradient(style:IStyle)->Bool {
        /*
        return StylePropertyParser.value(skin, CSSConstants.FILL, depth) is Gradient || StylePropertyParser.value(skin, "line", depth) is Gradient;
        */
        return false
    }
    class func hasAsset(style:IStyle)->Bool {
        /*
        return StylePropertyParser.value(skin, CSSConstants.FILL, depth) is Array;
        */
        return false
    }
    class func hasDropShadow(style:IStyle)->Bool {
        /*
        return StylePropertyParser.value(skin, CSSConstants.DROP_SHADOW, depth) is DropShadowFilter;
        */
        return false
    }
}