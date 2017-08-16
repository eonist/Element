import Foundation
struct WeightedStyle:Stylable/*,Comparable*/{
    /*private(set) internal */var styleWeight:StyleWeight
    var style:Stylable
    init(_ style:Stylable, _ styleWeight:StyleWeight) {
        self.styleWeight = styleWeight;
        self.style = style//super.init(style.name,style.selectors,style.styleProperties);
    }
}
extension WeightedStyle{
    var name:String {return style.name}
    var selectors:[SelectorKind] {get {return style.selectors}}
    var styleProperties:[StylePropertyKind] {get{return style.styleProperties}set{style.styleProperties = newValue}}
}
/*
func < (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber < rhs.someNumber
}
func == (lhs: WeightedStyle, rhs: WeightedStyle) -> Bool {
    return lhs.someNumber == rhs.someNumber
}
*/
