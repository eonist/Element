import Foundation

class DropShadowDecorator:GraphicDecoratable{
    var dropShadow:DropShadow
    init(_ decoratable: IGraphicDecoratable,_ dropShadow:DropShadow) {
        self.dropShadow = dropShadow
        super.init(decoratable)
    }
}