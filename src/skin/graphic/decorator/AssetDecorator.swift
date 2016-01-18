import Foundation
/*
 * // :TODO: this solution isnt perfect but it works for now
 * @Note asset is svg for now but in the future it should support png
 */
class AssetDecorator:SizeableDecorator{
    var asset : SVGAsset;
    var assetURL : String;
    init(_ decoratable: IGraphicDecoratable,_ iconURL:String) {//this shoul d be provided through an extension not here->  = BaseGraphic(FillStyle(NSColor.greenColor())
        _assetURL = iconURL;
        super.init(decoratable)
    }
    override func drawFill() {
        <#code#>
    }
    func beginFill() {
        <#code#>
    }
    override func drawLine() {
        /*this method must be overridden*/
    }
}
