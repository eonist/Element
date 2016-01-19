import Cocoa
/*
 * // :TODO: this solution isnt perfect but it works for now
 * @Note asset is svg for now but in the future it should support png
 */
class AssetDecorator:SizeableDecorator{
    var asset : SVGAsset?
    var assetURL : String;
    init(_ decoratable: IGraphicDecoratable,_ iconURL:String) {//this shoul d be provided through an extension not here->  = BaseGraphic(FillStyle(NSColor.greenColor())
        assetURL = iconURL;
        Swift.print("AssetDecorator.init() ")
        Swift.print("assetURL: " + "\(assetURL)")
        super.init(decoratable)
        asset = graphic.addSubView(SVGAsset(assetURL)) as? SVGAsset
    }
    override func beginFill() {
        Swift.print("beginFill()")
        super.beginFill()
        if(asset != nil) {asset!.removeFromSuperview()};/*temp solution*/
        asset = graphic.addSubView(SVGAsset(assetURL)) as? SVGAsset
        if(graphic.fillStyle!.color != NSColor.clearColor()) {asset!.applyStyle(graphic.fillStyle,graphic.lineStyle)}
    }
    override func drawFill() {
        Swift.print("drawFill()")
        asset!.draw(0, 0, width, height)//0, 0, graphic.width, graphic.height
    }
    override func drawLine() {
        /*this method must be overridden*/
    }
}