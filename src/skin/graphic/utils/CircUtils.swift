import Foundation

class CircUtils {
    /*
    /**
     * Returns an PrimitiveCirc, with correct position according to lineOffsetType
     */
    class func offsetCirc(circ:PrimitiveCirc, offsetType:OffsetType, lineStyle:ILineStyle)->PrimitiveCirc {
    if(offsetType.offsetType == OffsetType.OUTSIDE || offsetType.offsetType == OffsetType.INSIDE) circ.radius = circ.radius + CircUtil.lineOffset(offsetType, lineStyle);/*if the offsetType is OUTSIDE or INSIDE then the coorinates to the lineShape needs to be calculated*/
    return circ;
    }
    /**
     * Returns the radius offset
     */
    class func lineOffset(offsetType:OffsetType, lineStyle:ILineStyle)->CGFloat{
    if(offsetType.offsetType == OffsetType.OUTSIDE) return 1 * (lineStyle.thickness/2);
    else if(offsetType.offsetType == OffsetType.INSIDE) return -1 *(lineStyle.thickness/2);
    else return 0;
    }
    */
}