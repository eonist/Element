import Foundation

/**
*
*/
class StyleParser {
    /**
    * // :TODO: write java doc
    */
    class func describe(style:IStyle){
        Swift.print(style.name+": ");
        for styleProperty : IStyleProperty in style.styleProperties {
            var value:String = ""
            if(styleProperty.value is String || styleProperty.value is Double || styleProperty.value is Bool || styleProperty.value is UInt || styleProperty.value is Int){
                value = String(styleProperty.value)
            }
            else {
                value = String(styleProperty.value)//ObjectParser.parse(styleProperty.value);//was if(styleProperty.value is Object)  //if the property is an object parse it
            }
            Swift.print(" " + styleProperty.name + ":" + value/* + " depth:"+styleProperty.depth*/);
        }
    }
}