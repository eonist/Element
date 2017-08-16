import Cocoa
@testable import Utils

extension StyleManager{
    /**
     * Locates and returns a Style by the PARAM: name.
     * RETURN: a Style
     */
    static func getStyle(_ name:String)->Stylable?{
        return self.styles.first(where:{$0.name == name})
    }
    static func getStyle(_ index:Int)->Stylable?{
        return styles[safe:index]//<-⚠️️ just added safe
    }
    /**
     * New
     */
    static func getStylePropVal(_ styleName:String, _ stylePropertyName:String, _ depth:Int = 0) -> Any?{
        return StyleManager.getStyle(styleName)?.getStyleProperty(stylePropertyName)?.value
    }
    /**
     * New
     */
    static func index(_ name:String) -> Int?{
        return styles.index(where: {$0.name == name})
    }
}
