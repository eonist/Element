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
 
    override func drawFill() {
        //Swift.print("SVGAsset.drawFill()")
        
        let scale:CGPoint = CGPoint(width/svg.width,height/svg.height);
        SVGModifier.scale(svg, CGPoint(x,y), scale);
        
        
        //CGRect(x,y,width,height)
        
        //CGRect(0,0,width,height)
    }
    override func drawLine() {
        //nothing
    }
    override func fill() {
        let svgStyle = SVGStyle()
        SVGModifier.style(svg, <#T##style: SVGStyle##SVGStyle#>)
    }
    func line() {
        //nothing
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
