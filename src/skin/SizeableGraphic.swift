import Foundation

class SizeableGraphic:PositionalGraphic,ISizeableGraphic {
    var width:CGFloat;
    var height:CGFloat;
    init(_ width:CGFloat,_ height:CGFloat,_ decoratable: IGraphicDecoratable) {
        self.width = width
        self.height = height
        super.init(decoratable)
    }
    override func getSizeableGraphic() -> ISizeableGraphic {
        return self
    }
}
