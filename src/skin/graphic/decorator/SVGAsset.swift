import Foundation

class SVGAsset:SizeableGraphic {
    var svg:SVG;
    override init(_ position: CGPoint, _ size: CGSize, _ decoratable: IGraphicDecoratable) {
        var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!

        //Swift.print("xml: " + xml.toXMLString());
        svg = SVGParser.svg(xml)
        addSubView(svg);
        super.init(position, size, decoratable)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
