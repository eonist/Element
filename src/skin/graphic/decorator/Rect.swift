import Foundation
/*
 * // :TODO: impliment margin padding ?!? maybe not
 * // :TODO: Try to impliment Rect3 into Element2 and do tests
 * // :TODO: add example in the javadoc
 */
class Rect : Graphic{
    var _width:Int;
    var _height:Int;
    override init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        super.init(fillStyle, lineStyle )
        self.width = width;
        self.height = height;
        fill();
        line();
    }
}
