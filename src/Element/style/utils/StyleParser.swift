import Foundation
@testable import Utils
/**
 * NOTE: One could use Vector<String> for speed etc, but that would make the framework less readable for now
 * NOTE: if you ever need to find the absolute herarchy path to an instance use this: StyleParser.hierarchicalStyleName(someInstance);//SomeClass someInstance AnotherClass anotherInstance etc
 * TODO: make support for int and uint values for styles that are not numbers
 */
class StyleParser {// :TODO: rename to StyleResolver, it doesnt feel like a normal parser class not all the functions here!?!?
    /**
     * TODO: depthCount should probably be set when you are creating the Style instance, depthcount may change depending on the usage, think love preview or animation
     */
    static func depthCount(_ style:IStyle)->Int{
        let propertyNames:Array<String> = stylePropertyNames(style)
        //Swift.print("propertyNames: " + "\(propertyNames)")
        let fillCount:Int = ArrayAsserter.has(propertyNames, "fill") ? style.getStyleProperties("fill").count : 0
        //Swift.print(style.getStyleProperties("fill"))
        //Swift.print("fillCount: " + "\(fillCount)")
        let lineCount:Int = ArrayAsserter.has(propertyNames, "line") ? style.getStyleProperties("line").count : 0
        return max(fillCount,lineCount)
    }
    /**
     * TODO: write documentation
     */
    static func describe(_ style:IStyle){
        Swift.print("StyleParser.describe()")
        Swift.print("style.name: " + style.name)
        //Swift.print("style.styleProperties: " + "\(style.styleProperties)")
        for styleProperty:IStyleProperty in style.styleProperties {
            var value:String = ""
            if(styleProperty.value is String || styleProperty.value is Double || styleProperty.value is Bool || styleProperty.value is UInt || styleProperty.value is Int){
                value =  "\(styleProperty.value)"
            }else {
                value = "\(styleProperty.value)"//ObjectParser.parse(styleProperty.value);//was if(styleProperty.value is Object)  //if the property is an object parse it
            }
            Swift.print(" " + styleProperty.name + ":" + value + " depth:" + "\(styleProperty.depth)")
        }
    }
    /**
     * Returns an array populated with style property names
     */
    static func stylePropertyNames(_ style:IStyle) -> Array<String>{
        var propertyNames:Array<String> = []
        for styleProperty:IStyleProperty in style.styleProperties{ 
            propertyNames.append(styleProperty.name)
        }
        return propertyNames
    }
    /**
     * PARAM: name the propertyname
     */
    static func index(_ style:IStyle, _ name:String, _ depth:Int = 0) -> Int {
        for i in 0..<style.styleProperties.count{
            let styleProperty : IStyleProperty  = style.styleProperties[i]
            if(styleProperty.name == name && styleProperty.depth == depth){ 
                return i 
            }
        }
        return -1
    }
}
