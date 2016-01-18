import Foundation

class SVGAsset:SizeableGraphic {
    var _svg:SVG;
    override init(_ position: CGPoint, _ size: CGSize, _ decoratable: IGraphicDecoratable) {
        super.init(position, size, decoratable)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
