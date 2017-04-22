import Foundation
struct WeightedStyle:IStyle/*,Comparable*/{
    /*private(set) internal */var styleWeight: StyleWeight
    var style:IStyle
    init(_ style:IStyle, _ styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        self.style = style//super.init(style.name,style.selectors,style.styleProperties);
    }
}
extension WeightedStyle{
    var name:String {return style.name}
    var selectors:[ISelector] {return style.selectors}
    var styleProperties:[IStyleProperty] {get{return styleProperties}set{styleProperties = newValue}}
}
/*
func < (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber < rhs.someNumber
}

func == (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber == rhs.someNumber
}
*/
