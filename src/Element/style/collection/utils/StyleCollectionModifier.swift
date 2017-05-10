import Foundation

class StyleCollectionModifier {
    /**
     * Merges PARAM: a with PARAM: b (Adds styles that are not present in PARAM: a, and merges but does not override styles that have the same name)
     */
    static func merge(_ a:inout IStyleCollection,_ b:IStyleCollection) {
        for styleB:IStyle in b.styles {
            var hasStyle:Bool = a.styles.first(where: { styleA in
                styleB.name == styleA.name
            }) != nil
            /*for var styleA:IStyle in */
            
               
            
            
            
            
            if(!hasStyle) {a.addStyle(styleB)}
        }
    }
}
