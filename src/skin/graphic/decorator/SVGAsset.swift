import Foundation
/**
 * TODO: Remember to add the cglayer settings so that this class can have children that is visible etc
 */
class SVGAsset:FlippedView {
    var svg:SVG;
    init(_ path:String) {
        Swift.print("SVGAsset.init()")
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let content = FileParser.content(path.tildePath)
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        super.init(frame: NSRect())
        svg = addSubView(SVGParser.svg(rootElement)) as! SVG
    }
    /**
     *
     */
    func draw(x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat) {
        Swift.print("SVGAsset.drawFill()")
        let scale:CGPoint = CGPoint(width/svg.width,height/svg.height);
        SVGModifier.scale(svg, CGPoint(x,y), scale);
    }
    /**
     *
     */
    func applyStyle(fillStyle:IFillStyle?,lineStyle:ILineStyle?){
        if(fillStyle != nil && lineStyle != nil){
            Swift.print("SVGAsset.fill()")
            //Swift.print("lineStyle: " + "\(lineStyle)")
            //Swift.print("fillStyle.color: " + "\(fillStyle.color)")
            //Swift.print("fillStyle.alpha: " + "\(fillStyle.alpha)")
            //Swift.print("lineStyle.color: " + "\(lineStyle.color)")
            //Swift.print("lineStyle.alpha: " + "\(lineStyle.alpha)")
            //Swift.print("lineStyle.thickness: " + "\(lineStyle.thickness)")
            //Swift.print("lineStyle.capStyle: " + "\(lineStyle.capStyle)")
            //Swift.print("lineStyle.jointStyle: " + "\(lineStyle.jointStyle)")
            //Swift.print("lineStyle.miterLimit: " + "\(lineStyle.miterLimit)")
            let fillStyle:IFillStyle = fillStyle!
            let lineStyle:ILineStyle = lineStyle!
            let svgStyle = SVGStyle(fillStyle.color,fillStyle.color.alphaComponent,nil,lineStyle.thickness,lineStyle.color,lineStyle.color.alphaComponent,LineStyleParser.lineCapType(lineStyle.lineCap),LineStyleParser.lineJoinType(lineStyle.lineJoin),lineStyle.miterLimit)
            SVGModifier.style(svg, svgStyle)
        }
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
