import Foundation

class StyleCollectionModifier {
    /**
     * Merges @param a with @param b (Adds styles that are not present in @param a, and merges but does not override styles that have the same name)
     */
    class func merge(a:IStyleCollection,b:IStyleCollection) {
        for styleB : IStyle in b.styles {
            var hasStyle:Bool = false
            for var styleA : IStyle in a.styles {
                if(styleB.name == styleA.name){// :TODO: untested may not work
                    hasStyle = true
                    StyleModifier.merge(&styleA, styleB)
                    break
                }
            }
            if(!hasStyle) {a.addStyle(styleB)}
        }
    }
}