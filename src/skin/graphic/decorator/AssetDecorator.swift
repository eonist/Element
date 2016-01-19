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
        Swift.print("AssetDecorator.init() " + "assetURL: " + "\(assetURL)")
        super.init(decoratable)
        asset = graphic.addSubView(SVGAsset(assetURL)) as? SVGAsset
    }
    override func beginFill() {
        Swift.print("AssetDecorator.beginFill() ")
        super.beginFill()
        if(asset != nil) {asset!.removeFromSuperview()};/*temp solution, find a more elegant solution than removing*/
        asset = graphic.addSubView(SVGAsset(assetURL)) as? SVGAsset/*temp solution*/
        if(graphic.fillStyle!.color != NSColor.clearColor()) {asset!.applyStyle(graphic.fillStyle,graphic.lineStyle)}
    }
    override func drawFill() {
        Swift.print("AssetDecorator.drawFill() width: " + "\(width)" + " height: " + "\(height)")
        asset!.draw(0, 0, width, height)//0, 0, graphic.width, graphic.height
    }
    override func drawLine() {
        /*this method must be overridden*/
    }
}