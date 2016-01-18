import Foundation
/*
 * // :TODO: this solution isnt perfect but it works for now
 * @Note asset is svg for now but in the future it should support png
 */
class AssetDecorator:SizeableDecorator{
    var asset : SVGAsset;
    var assetURL : String;
    init(_ decoratable: IGraphicDecoratable,_ iconURL:String) {//this shoul d be provided through an extension not here->  = BaseGraphic(FillStyle(NSColor.greenColor())
        assetURL = iconURL;
        super.init(decoratable)
    }
    override func drawFill() {
        if(asset != nil) {graphic.addSubview(self)};/*temp solution*/
        _asset = graphic.addChild(new SVGAsset(assetURL) as Sprite) as SVGAsset;
        if(!isNaN(graphic.fillStyle.color)) _asset.applyStyle(graphic.fillStyle,graphic.lineStyle);
    }
    func beginFill() {
        asset.draw()//0, 0, graphic.width, graphic.height
    }
    override func drawLine() {
        /*this method must be overridden*/
    }
}
