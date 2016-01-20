import Foundation

class FillStyleParser {
    /**
     * NOTE: You could also add this as a Descrieable extension on the ILineStyle protocol but, its convenient enough to keep it here. 
     */
    class func describe(fillStyle:IFillStyle){
        Swift.print("FillStyleParser.describe()")
        Swift.print("fillStyle.color.hex: " + "\(fillStyle.color.hex)")
        Swift.print("fillStyle.color.alphaComponent: " + "\(fillStyle.color.alphaComponent)")
    }
}
