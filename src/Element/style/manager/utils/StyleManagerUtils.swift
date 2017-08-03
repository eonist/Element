import Foundation
@testable import Utils

class StyleManagerUtils{
    static var stylesByElement:[String:[IStyle]] = [:]
    static var stylesByID:[String:[IStyle]] = [:]
    static var stylesByClassId:[String:[IStyle]] = [:]
    static var stylesByState:[String:[IStyle]] = [:]
    /**
     * We hash the tail of the style selectors
     * NOTE: Using if let won't work on the code bellow
     * TODO: Tail trick is nice, but it complicates the code, try to pursue other avenues in optimization, bisect search comes to mind.
     */
    static func hashStyle(_ style:IStyle){
        if style.selectors.last!.element != "" {
            if stylesByElement[style.selectors.last!.element] != nil {
                stylesByElement[style.selectors.last!.element]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.element] = [style]
            }
        }
        if style.selectors.last!.id != "" {
            if (stylesByID[style.selectors.last!.id] != nil){
                stylesByID[style.selectors.last!.id]!.append(style)
            }else{
                stylesByID[style.selectors.last!.id] = [style]
            }
        }
        if !style.selectors.last!.classIds.isEmpty {//temp solution, you need to flatten the classIds somehow, or test individual etc
            if (stylesByClassId[style.selectors.last!.classIds.first!] != nil){
                stylesByClassId[style.selectors.last!.classIds.first!]!.append(style)
            }else{
                stylesByClassId[style.selectors.last!.classIds.first!] = [style]
            }
        }
        if !style.selectors.last!.states.isEmpty {//temp solution, you need to flatten the states somehow, or test individual etc
            if  stylesByState[style.selectors.last!.states.first!] != nil {
                stylesByState[style.selectors.last!.states.first!]!.append(style)
            }else{
                stylesByState[style.selectors.last!.states.first!] = [style]
            }
        }    
    }
    /**
     * New
     */
    static func styles(_ cssString:String, removeComments:Bool = true) -> [IStyle]{
        let resolvedLinksCSS = CSSLinkResolver.resolveLinks(cssString)
        let removedCommentsCSS =  removeComments ? RegExpModifier.removeComments(resolvedLinksCSS) : resolvedLinksCSS
        return CSSParser.styleCollection(removedCommentsCSS).styles
    }
    static let relativeURLPattern = "(?=[,: ]?)([\\w/~.]+.svg)(?=[,; ]?)"
    /**
     * New
     */
    static func expandURLS(_ cssStr:String, baseURL:String) -> String{
        let result = cssStr.replace(relativeURLPattern){
            Swift.print("$0: " + "\($0)")
            let expandedURL:String = FilePathModifier.expand($0, baseURL: baseURL)//returns a filepath that is absolute
            Swift.print("expandedURL: " + "\(expandedURL)")
            let userAgnosticFilePath:String = expandedURL.tildify//makes the filePath user agnostic
            Swift.print("userAgnosticFilePath: " + "\(userAgnosticFilePath)")
            return userAgnosticFilePath
        }
        return result
    }
}
