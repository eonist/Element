import Foundation
@testable import Utils
/**
 * NOTE: The reason we use array instead of object: a problem may be that the order will be different every time you read this object, random
 * EXAMPLE: print("StyleManager.getInstance().getStyle(Button): " + StyleManager.getInstance().getStyle("someText").getPropertyNames());//prints style names
 * TODO: ⚠️️ Could potentially extend StyleCollection and just implimnet the extra functions in this class?!?
 * TODO: ⚠️️⚠️️⚠️️ This class can be a struct maybe?
 * TODO: ⚠️️ Use singleton pattern instead
 * TODO: ⚠️️ The tail trick could possibly be even faster if you sorted the hashed styles and used a halfed algo when querrying (but its a dictionary so maybe not, maybe if you stored it in an array etc)
 */
class StyleManager{
    static var cssFiles:[String:String] = [:]
    static var cssFileURLS:[String] = []//store only relative paths
    static var styles:[Stylable] = []
    static var isHashingStyles:Bool = true/*enable this if you want to hash the styles (beta)*/
    static let cacheURL:String = FilePathParser.resourcePath() + "/assets.bundle/styles/styles.xml"//"~/Desktop/styles.xml".tildePath
}
