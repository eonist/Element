import Foundation
/**
 * @Note: One could use  Vector<String> for speed etc, but that would make the framework less readable for now
 * @Note if you ever need to find the absolute herarchy path to an instance use this: StyleParser.hierarchicalStyleName(someInstance);//SomeClass someInstance AnotherClass anotherInstance etc
 * // :TODO: make support for int and uint values for styles that are not numbers
 */
class StyleParser {// :TODO: rename to StyleResolver, it doesnt feel like a normal parser class not all the functions here!?!?
    /**
     * // :TODO: depthCount should probably be set when you are creating the Style instance, depthcount may change depending on the usage, think love preview or animation
     */
    class func depthCount(style:IStyle)->Int{
        let propertyNames:Array<String> = stylePropertyNames(style)
        //Swift.print("propertyNames: " + "\(propertyNames)")
        let fillCount:Int = ArrayAsserter.has(propertyNames, "fill") ? style.getStyleProperties("fill").count : 0
        //Swift.print(style.getStyleProperties("fill"))
        //Swift.print("fillCount: " + "\(fillCount)")
        let lineCount:Int = ArrayAsserter.has(propertyNames, "line") ? style.getStyleProperties("line").count : 0
        return max(fillCount,lineCount)
    }
    /**
     * // :TODO: write java doc
     */
    class func describe(style:IStyle){
        Swift.print("StyleParser.describe()")
        Swift.print(style.name+": ");
        for styleProperty : IStyleProperty in style.styleProperties {
            var value:String = ""
            if(styleProperty.value is String || styleProperty.value is Double || styleProperty.value is Bool || styleProperty.value is UInt || styleProperty.value is Int){
                value =  String(styleProperty.value)
            }
            else {
                value = String(styleProperty.value)//ObjectParser.parse(styleProperty.value);//was if(styleProperty.value is Object)  //if the property is an object parse it
            }
            Swift.print(" " + styleProperty.name + ":" + value + " depth:" + "\(styleProperty.depth)")
        }
    }
    /**
     * Returns an array populated with style property names
     */
    class func stylePropertyNames(style:IStyle) -> Array<String>{
        var propertyNames:Array<String> = []
        for styleProperty : IStyleProperty in style.styleProperties{ propertyNames.append(styleProperty.name) }
        return propertyNames;
    }
    /**
     * @param name the propertyname
     */
    class func index(style:IStyle, _ name:String, _ depth:Int = 0) -> Int {
        let len:Int = style.styleProperties.count
        for (var i : Int = 0; i < len; i++) {
            let styleProperty : IStyleProperty  = style.styleProperties[i]
            if(styleProperty.name == name && styleProperty.depth == depth){ return i }
        }
        return -1
    }
}
