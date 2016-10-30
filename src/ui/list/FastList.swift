import Foundation

class FastList:Element {
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
        //Add 20 rects to a list (random colors) 100x50
        //mask 100x400
        
        //move a "virtual" list up and down by: (just by values) (se code for this in List.swift)
            //
        
    }
    override func resolveSkin() {
        super.resolveSkin()
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}
