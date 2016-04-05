import Foundation

class GradientSlider:HNodeSlider{
    init(_ width : CGFloat = NaN, _ height : CGFloat = NaN, _ nodeWidth : CGFloat = NaN, _ gradient:IGradient? = nil, _ startProgress : CGFloat = 0, _ endProgress : CGFloat = 1, _ parent : IElement? = nil, _ id : String = "") {
        super.init(width, height, nodeWidth, startProgress, endProgress, parent, id)
        //setGradient(gradient)
    }
    func setGradient(gradient:IGradient){
        //trace("setGradient"+gradient.colors);
        self.gradient = gradient
        //trace("_gradient: " + _gradient);
        var style:IStyle = StyleModifier.clone(skin.style,skin.style.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        style.getStyleProperty("fill").value = gradient/*edits the style*/
        //skin.setState(SkinStates.NONE);/*update the skin*/
        skin.setStyle(style)/*updates the skin*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
