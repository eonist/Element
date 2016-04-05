import Foundation

class GradientSlider:HNodeSlider{
    init(_ width : CGFloat = NaN, _ height : CGFloat = NaN, _ nodeWidth : CGFloat = NaN, _ gradient:IGradient? = nil, _ startProgress : CGFloat = 0, _ endProgress : CGFloat = 1, _ parent : IElement? = nil, _ id : String = "") {
        super.init(width, height, nodeWidth, startProgress, endProgress, parent, id)
        //setGradient(gradient)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
