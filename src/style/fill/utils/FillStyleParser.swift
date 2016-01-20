import Foundation

class FillStyleParser {
    /**
     *
     */
    class func describe(fillStyle:IFillStyle){
        Swift.print("fillStyle.color: " + "\(fillStyle.color)")
        Swift.print("fillStyle.color.alphaComponent: " + "\(fillStyle.color.alphaComponent)")
    }
}
