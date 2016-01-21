import Cocoa
/**
 * TODO: Remember to add the cglayer settings so that this class can have children that is visible etc
 */
class SVGAsset:FlippedView {
    var svg:SVG
    init(_ path:String) {
        //Swift.print("SVGAsset.init()")
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let content = FileParser.content(path.tildePath)
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        svg = SVGParser.svg(rootElement)
        super.init(frame: NSRect())
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
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
        return SVGStyle(fillStyle != nil ? fillStyle!.color.rgb : nil,fillStyle != nil ? fillStyle!.color.alphaComponent : nil,nil,lineStyle != nil ? lineStyle!.thickness : nil,lineStyle != nil ? lineStyle!.color : nil,lineStyle != nil ? lineStyle!.color.alphaComponent : nil,lineStyle != nil ? LineStyleParser.lineCapType(lineStyle!.lineCap) : nil,lineStyle != nil ? LineStyleParser.lineJoinType(lineStyle!.lineJoin): nil,lineStyle != nil ? lineStyle!.miterLimit : nil)
    }
}





