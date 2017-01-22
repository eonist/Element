import Foundation

class GraphUtils{
    /**
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     * PARAM: vValues y-axis values
     * PARAM: maxValue (the max value among the y-axis values)
     */
    static func points(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ vValues:[CGFloat], _ maxValue:CGFloat) -> [CGPoint]{
        var points:[CGPoint] = []
        let x:CGFloat = /*position.x*/ spacing.width
        let y:CGFloat = /*position.y +*/ size.height// - (spacing.height*2)
        let h:CGFloat = size.height-(spacing.height*2)
        for i in 0..<vValues.count{//calc the graphPoints:
            var p = CGPoint()
            let value:CGFloat = vValues[i]
            let ratio:CGFloat = maxValue/value/*a value between 0-1*/
            p.x = x + (i * spacing.width)
            p.y = y - h*ratio
            points.append(p)
        }
        return points
    }
    /**
     * Generates value indicators that match up with the (data set)
     */
    static func verticalIndicators(_ vCount:Int,_ maxValue:CGFloat)->[String]{
        var strings:[String] = []
        for i in (0..<vCount).reversed() {//swift 3 update
            //Swift.print("i: " + "\(i)")
            var num:CGFloat = (maxValue/(vCount.cgFloat-1))*i
            //Swift.print("num: " + "\(num)")
            num = round(num)//NumberModifier.toFixed(num, 1)//
            let str:String = num.string
            strings.append(str)
            //Tip: use skin.getWidth() if you need to align Element items with Align
        }
        return strings
    }
}
