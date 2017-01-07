import Foundation
/**
 * NOTE: a datastorage class ("bean") parsing should be done elsewhere!
 * // :TODO: get rid of name?!?
 */
class StyleCollection:IStyleCollection{
    var styles:Array<IStyle> = []//use obj instead?
}
extension StyleCollection{
    /**
     * Adds every style in an array to the_styles array (uses the addStyle method to do it so that it checks for duplicates)
     * NOTE: the reason we dont move the following core methods into StyleCollectionModifier is because they are used alot and are not that complex
     */
    func addStyles(styles:Array<IStyle>){
        for style in styles{ addStyle(style) }
    }
    /**
     * Adds a style to the StyleCollection instance
     * PARAM: style: IStyle
     */
    func addStyle(style:IStyle){
        for var styleItem in styles {
            if(styleItem.name == style.name) {/*if there are duplicates merge them*/
                StyleModifier.combine(&styleItem, style)/*<--was merge, but styles that comes later in the array with the same name should hard-override properties, not soft-override like it was previously*/
                return//you can also do break
            }
        }
        styles.append(style)
    }
    /**
     * TODO: One Could change this to return nothing
     * RETURNS: the removed Style
     */
    func removeStyle(name:String)->IStyle?{
        for i in 0..<styles.count{//swift 3 for loop upgrade
            if((styles[i] as IStyle).name == name){
                return ArrayModifier.splice2(&styles,i,1) as? IStyle
            }
        }
        return nil/*could also return the index i guess -1 instead of nil, do we need to return anything ? its nice to be able to assert if something was removed with nil coalesing as it is now*/
    }
    /**
     * NOTE: We can't use a for each loop here since it returns inside the loop clause, and forEach doesn't allow for that
     */
    func getStyle(name:String)->IStyle?{
        for i in 0..<styles.count{//swift 3
            if((styles[i] as IStyle).name == name) {
                return  styles[i]
            }
        }
        return nil
    }
    /**
     * Convenience
     */
    func getStyleAt(index:Int)->IStyle?{
        return styles[index]
    }
}