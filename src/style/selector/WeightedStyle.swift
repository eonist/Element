import Foundation

class WeightedStyle:Style,Comparable{// :TODO: move into its own class?
    /*private(set) internal */var styleWeight: StyleWeight
    init(_ style:IStyle, _ styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        super.init(style.name,style.selectors,style.styleProperties);
    }
}
