import Foundation

class FastList:Element {
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
