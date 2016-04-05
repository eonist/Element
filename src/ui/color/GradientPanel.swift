import Foundation

class GradientPanel:Element{
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, gradient:IGradient? = nil, _ title:String = "Color", _ parent:IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight
        self.color = color
        super.init(width, height, parent, id)
    }
}
