import Foundation
class WeightedStyle:Style/*,Comparable*/{
    /*private(set) internal */var styleWeight: StyleWeight
    init(_ style:IStyle, _ styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        super.init(style.name,style.selectors,style.styleProperties);
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