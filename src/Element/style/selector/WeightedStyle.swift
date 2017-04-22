import Foundation
struct WeightedStyle:IStyle/*,Comparable*/{
    /*private(set) internal */var styleWeight: StyleWeight
    var style:IStyle
    init(_ style:IStyle, _ styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        self.style = style//super.init(style.name,style.selectors,style.styleProperties);
    }
}
/*
func < (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber < rhs.someNumber
}

func == (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber == rhs.someNumber
}
*/
