import Foundation

class AssetDecorator:SizeableDecorator{
    init(_ path:String, _ position: CGPoint, _ size: CGSize, _ decoratable: IGraphicDecoratable) {
        Swift.print("SVGAsset.init()")
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+path));
        let content = FileParser.content(path.tildePath)
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        svg = SVGParser.svg(rootElement);
        super.init(position, size, decoratable)
        graphic.addSubview(svg)
    }
}
