import Foundation

class StyleCollectionLinkageResolver {
    /**
     * Resolves linking on @param styleCollection
     * // :TODO: what if the link is not found? should we provide a default value? or remove the stylepropp maybe?
     */
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
}
