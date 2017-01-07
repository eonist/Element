import Cocoa
/**
 * TODO: Remember to add the cglayer settings so that this class can have children that is visible etc
 * TODO: You need to think how you can add trackingareas to all svg children aswell and subsequent hitTest, just get the bounds and assert isWithinPath in a tree-search
 */
class SVGAsset:InteractiveView2 {
    var svg:SVG
    init(_ path:String) {
        let rootElement:XML = FileParser.xml(path.tildePath)
        svg = SVGParser.svg(rootElement)
        super.init(frame: NSRect())
        isInteractive = false/*<--very important, as SVG interactivity is currently not supported*/
        /*self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children, or not!*/
        layer!.masksToBounds = false//this is needed!!!, seems not to be needed!*/
        addSubview(svg)
    }
    /**
     * TODO: explain what this method does
     */
    func draw(x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) {
        //Swift.print("SVGAsset.drawFill() width: " + String(width) + " height: " + String(height) + " x: " + String(x) + " y: " + String(y))
        let scale:CGPoint = CGPoint(width/svg.width,height/svg.height)//<---why is this working? could be because you have tested only with square svg files
        //Swift.print("svg.width: " + "\(svg.width)")
        //Swift.print("svg.height: " + "\(svg.height)")
        //Swift.print("scale: " + "\(scale)")
        SVGModifier.scale(svg, CGPoint(0,0), scale)
        svg.setFrameOrigin(CGPoint(x,y))
    }
    /**
     *
     */
    func applyStyle(fillStyle:IFillStyle?,_ lineStyle:ILineStyle?){
        //Swift.print("SVGAsset.applyStyle()")
        //if(fillStyle != nil){FillStyleParser.describe(fillStyle!)}
        //if(lineStyle != nil){LineStyleParser.describe(lineStyle!)}
        let svgStyle = Utils.svgStyle(fillStyle, lineStyle)
        //SVGStyleParser.describe(svgStyle)
        SVGModifier.style(svg, svgStyle)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     * NOTE: this method is here because This framework uses swift-utils and SVGLib. Neither of them uses either of them. Think coupling etc
     */
    class func svgStyle(fillStyle:IFillStyle?,_ lineStyle:ILineStyle?)->SVGStyle{
        let fill:Any? = fillStyle != nil ? fillStyle!.color.hexVal : nil
        let fillOpacity:CGFloat? = fillStyle != nil ? fillStyle!.color.alphaComponent : nil
        let fillRule:String? = nil
        let strokeWidth:CGFloat? = lineStyle != nil ? lineStyle!.thickness : nil
        let stroke:Any? = lineStyle != nil && lineStyle?.color != NSColor.clearColor()/*<--TODO: add this check to fill.color aswell*/ ? lineStyle!.color : nil
        let strokeOpacity:CGFloat? = lineStyle != nil ? lineStyle!.color.alphaComponent : nil
        let strokeLineCap:String? = lineStyle != nil ? LineStyleParser.lineCapType(lineStyle!.lineCap) : nil
        let strokeLineJoin:String? = lineStyle != nil ? LineStyleParser.lineJoinType(lineStyle!.lineJoin) : nil
        let strokeMiterLimit:CGFloat? = lineStyle != nil ? lineStyle!.miterLimit : nil
        return SVGStyle(fill,fillOpacity,fillRule,strokeWidth,stroke,strokeOpacity,strokeLineCap,strokeLineJoin,strokeMiterLimit)
    }
}