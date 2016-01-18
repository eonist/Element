import Foundation

class AssetDecorator:SizeableDecorator{
    init(_ decoratable: IGraphicDecoratable) {//this shoul d be provided through an extension not here->  = BaseGraphic(FillStyle(NSColor.greenColor())
        
        super.init(decoratable)
    }
}
