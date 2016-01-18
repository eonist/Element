import Foundation

class SVGAsset:SizeableGraphic {
    var svg:SVG;
    init(_ path:String, _ position: CGPoint, _ size: CGSize, _ decoratable: IGraphicDecoratable) {
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let content = FileParser.content(path.tildePath)
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        svg = SVGParser.svg(rootElement);
        super.init(position, size, decoratable)
        graphic.addSubview(svg)
    }
    public function draw(x : Number, y : Number, width : Number, height : Number) : void {
        var scale:Point = new Point(width/_svg.width,height/_svg.height);
        SVGModifier.scale(_svg, new Point(x,y), scale);
    }
    
    override func drawFill() {
        //Swift.print("EllipseGraphic.drawFill()")
        let fillFrame = graphic.lineStyle != nil ?  RectGraphicUtils.fillFrame(CGRect(x,y,width,height), graphic.lineStyle!.thickness, graphic.lineOffsetType) : CGRect(x,y,width,height)
        graphic.fillShape.frame = fillFrame/*,position and set the size of the frame*/
        graphic.fillShape.path = CGPathParser.ellipse(CGRect(0,0,width,height))
    }
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
