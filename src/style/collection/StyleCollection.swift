import Foundation

class StyleCollection:IStyleCollection{
    var styles:Array<IStyle> = [];//use obj instead?
    
    /**
    * Adds every style in an array to the_styles array (uses the addStyle method to do it so that it checks for duplicates)
    * @Note the reason we dont move the following core methods into StyleCollectionModifier is because they are used alot and are not that complex
    */
    func addStyles(styles:Array<IStyle>){
        for style in styles{ addStyle(style) }
    }
    /**
     * Adds a style to the StyleCollection instance
     * @param style: IStyle
     */
    func addStyle(style:IStyle){
        for (var i : Int = 0; i < styles.count; i++) {
            if(IStyle(_styles[i]).name == style.name) {/*if there are duplicates merge them*/
                StyleModifier.merge(_styles[i], style);
                return;
            }
        }
        _styles.push(style);
    }
    func removeStyle(name:String)->IStyle{
        
    }
    func getStyle(name:String)->IStyle{
        
    }
    func getStyleAt(index:Int)->IStyle{
        
    }
}