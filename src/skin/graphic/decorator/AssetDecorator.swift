import Foundation
/*
 * // :TODO: this solution isnt perfect but it works for now
 * @Note asset is svg for now but in the future it should support png
 */
class AssetDecorator:SizeableDecorator{
    var asset : SVGAsset;
    var assetURL : String;
    override init(_ decoratable: IGraphicDecoratable) {//this shoul d be provided through an extension not here->  = BaseGraphic(FillStyle(NSColor.greenColor())
        
        super.init(decoratable)
    }
}
