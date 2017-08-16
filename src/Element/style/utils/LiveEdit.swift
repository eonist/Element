import Foundation

class LiveEdit {
    /**
     * Removes styles that have been refreshed
     */
    static func styles(_ stylesURL:String) -> [Stylable]{
        let cssString:String = CSSFileParser.cssString(stylesURL)
        let styles = StyleManagerUtils.styles(cssString)
        if let cssStr = StyleManager.cssFiles[stylesURL]{/*check if the url already exists in the dictionary*/
//          cssStr = CSSLinkResolver.resolveLinks(cssFile)
            let styles:[Stylable] = StyleManagerUtils.styles(cssStr)
            StyleManager.removeStyle(styles)/*if url exists then remove the styles that it represents*/
        }else{/*If the url wasn't in the dictionary, then add it*/
            StyleManager.cssFiles[stylesURL] = cssString//<--I'm not sure how this works, but it works
        }
        return styles
    }
}
