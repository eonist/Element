import Foundation
/**
 * @Note StyleLinkageResolver is a better name than StyleLinkingParser
 * TODO: remove this class, as this is handled somewhere else now
 */
class StyleCollectionLinkageResolver {
    /**
     * Resolves linking on @param styleCollection
     * // :TODO: what if the link is not found? should we provide a default value? or remove the stylepropp maybe?
     */
    //TODO: to finish the bellow you just copy the code from CSSLinkResolver
    /*
    class func resolveLinkage(styleCollection:IStyleCollection) -> IStyleCollection {
        var bracketPattern:RegExp = new RegExp("(?<=<).+?(?=>)","g");
        for var style : IStyle in styleCollection.styles {
            for var styleProperty : IStyleProperty in style.styleProperties {
                if(bracketPattern.test(styleProperty.value)) {/*find a property that has the format of <styleName>*/
                    var linkedStyleName:String = (styleProperty.value as String).match(bracketPattern)[0];
                    var linkedStyle:IStyle = styleCollection.getStyle(linkedStyleName);
                    var linkedStyleProperty:* = linkedStyle.getValue(styleProperty.name);
                    var replacePattern:RegExp = new RegExp("<"+linkedStyleName+">","g");
                    styleProperty.value = (styleProperty.value as String).replace(replacePattern, linkedStyleProperty);
                }
            }
        }
        return styleCollection;
    }
    */
}