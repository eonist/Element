import Foundation

class StyleCollectionModifier {
    /**
     * Merges PARAM: a with PARAM: b (Adds styles that are not present in PARAM: a, and merges but does not override styles that have the same name)
     */
    static func merge(a:IStyleCollection,b:IStyleCollection) {
        for styleB:IStyle in b.styles {
            var hasStyle:Bool = false
            for var styleA:IStyle in a.styles {
                if(styleB.name == styleA.name){//TODO: untested may not work
                    hasStyle = true
                    StyleModifier.merge(&styleA, styleB)
                    break/*breaks out of the for-loop*/
                }
            }
            if(!hasStyle) {a.addStyle(styleB)}
        }
    }
}