import Cocoa
@testable import Element

class StyleMetricParser {
    /**
     * Returns Offset
     * TODO: ⚠️️ Merge ver/hor Offset into this one like you did with cornerRadius
     * TODO: ⚠️️ Add support for % as it isnt implemented yet, see the margin implementation for guidance
     */
    static func offset(_ skin:ISkin,_ depth:Int = 0)->CGPoint {
        guard let value:Any = self.value(skin, CSSConstants.offset.rawValue, depth) else{
            return CGPoint(0,0)//<---temp solution
        }
        let array:[CGFloat] = {
            if let value = value as? CGFloat {
                return [value]
            };return (value as! [Any]).cast()
        }()
        return array.count == 1 ? CGPoint(array[0],0) : CGPoint(array[0], array[1])
    }
}
