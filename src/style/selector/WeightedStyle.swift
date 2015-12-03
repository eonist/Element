import Foundation

class WeightedStyle:Style{// :TODO: move into its own class?
    var styleWeight:StyleWeight;
    init(style:IStyle, styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        super.init(style.name,style.selectors,style.styleProperties);
    }
}
