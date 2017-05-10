import Foundation

class StyleCollectionModifier {
    /**
     * Merges PARAM: a with PARAM: b (Adds styles that are not present in PARAM: a, and merges but does not override styles that have the same name)
     */
    static func merge(_ a:inout IStyleCollection,_ b:IStyleCollection) {
        b.styles.forEach { styleB in
            if var match = a.styles.first(where:{styleA in styleA.name == styleB.name}){
                StyleModifier.merge(&match, styleB)
            }else{
                a.addStyle(styleB)
            }
        }
    }
}
