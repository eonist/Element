import Foundation
@testable import Utils

extension IStyleCollection{
    /**
     * Adds every style in an array to the_styles array (uses the addStyle method to do it so that it checks for duplicates)
     * NOTE: the reason we dont move the following core methods into StyleCollectionModifier is because they are used alot and are not that complex
     */
    mutating func addStyles(_ styles:[IStyle]){
        styles.forEach{style in addStyle(style)}
    }
    /**
     * Adds a style to the StyleCollection instance
     * PARAM: style: IStyle
     */
    mutating func addStyle(_ style:IStyle){
        if let matchIdx = styles.index(where: {$0.name == style.name}){
            StyleModifier.combine(&styles[matchIdx], style)/*<--was merge, but styles that comes later in the array with the same name should hard-override properties, not soft-override like it was previously*/
        }
        styles.append(style)
    }
    /**
     * TODO: One Could change this to return nothing
     * RETURNS: the removed Style
     */
    mutating func removeStyle(_ name:String)->IStyle?{
        if let idx = styles.index(where: {$0.name == name}){
            return ArrayModifier.splice2(&styles,idx,1).first
        }
        return nil/*could also return the index i guess -1 instead of nil, do we need to return anything ? its nice to be able to assert if something was removed with nil coalesing as it is now*/
    }
    /**
     * NOTE: We can't use a for each loop here since it returns inside the loop clause, and forEach doesn't allow for that
     */
    func getStyle(_ name:String)->IStyle?{
        return styles.first(where: {$0.name == name})
    }
    /**
     * Convenience
     */
    func getStyleAt(_ index:Int)->IStyle?{
        return styles[index]
    }
}
