import Cocoa
/**
 * TODO: Remember to add the cglayer settings so that this class can have children that is visible etc
 * TODO: you need to think how you can add trackingareas to all svg children aswell and subsequent hitTest, just get the bounds and assert isWithinPath in a tree-search
 */
class SVGAsset:InteractiveView2 {
    var svg:SVG
    init(_ path:String) {
        //Swift.print("SVGAsset.init()")
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let content = FileParser.content(path.tildePath)//TODO: you need to make a tilePath assert
        //Swift.print("content: " + "\(content)")
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        svg = SVGParser.svg(rootElement)
        super.init(frame: NSRect())
        /*self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!*/
        addSubview(svg)
    }
    /**
     *
     */
    func draw(x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) {
        //Swift.print("SVGAsset.drawFill() width: " + String(width) + " height: " + String(height) + " x: " + String(x) + " y: " + String(y))
        let scale:CGPoint = CGPoint(width/svg.width,height/svg.height);
        //Swift.print("svg.width: " + "\(svg.width)")
        //Swift.print("svg.height: " + "\(svg.height)")
        //Swift.print("scale: " + "\(scale)")
        
        SVGModifier.scale(svg, CGPoint(0,0), scale);
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
     * NOTE: this method is here because This framework uses swift-utils and SVGLib. Neither of theme uses either of them. Think coupling etc
     * @NOTE: why the long method call? I feel the arguments are so simple that it can be done this way. You can debug by describing the SVGStyle or the Style with the describe methods etc
     */
    class func svgStyle(fillStyle:IFillStyle?,_ lineStyle:ILineStyle?)->SVGStyle{
        
        //TODO: the bellow line is now so complex that you should explode it, difficult to debug!
        let fill:Any? = fillStyle != nil ? fillStyle!.color.hexVal : nil
        let fillOpacity:CGFloat? = fillStyle != nil ? fillStyle!.color.alphaComponent : nil
        let fillRule:String? = nil
        let strokeWidth:CGFloat? = lineStyle != nil ? lineStyle!.thickness : nil
        let stroke:Any? = lineStyle != nil && lineStyle?.color != NSColor.clearColor()/*<--TODO: add this check to fill.color aswell*/ ? lineStyle!.color : nil
        return SVGStyle(fill,fillOpacity,fillRule,strokeWidth,stroke,strokeOpacity,lineStyle != nil ? LineStyleParser.lineCapType(lineStyle!.lineCap) : nil,lineStyle != nil ? LineStyleParser.lineJoinType(lineStyle!.lineJoin): nil,lineStyle != nil ? lineStyle!.miterLimit : nil)
    }
}