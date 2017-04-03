import Foundation
@testable import Utils

class GraphUtils{
    /**
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     * NOTE: Conforms the vValues to fit a predefined rect. 
     * PARAM: vValues y-axis values
     * PARAM: maxValue (the max value among the y-axis values)
     */
    static func points(_ size:CGSize,_ position:CGPoint,_ spacing:CGSize, _ vValues:[CGFloat], _ maxValue:CGFloat) -> [CGPoint]{
        //Swift.print("size.height: " + "\(size.height)")
        //Swift.print("spacing.height: " + "\(spacing.height)")
        var points:[CGPoint] = []
        let x:CGFloat = /*position.x*/ spacing.width
        let y:CGFloat = /*position.y +*/ size.height - (spacing.height)//the y point to start from, basically bottom
        let h:CGFloat = size.height-(spacing.height*2)//the height to work within
        //Swift.print("h: " + "\(h)")
        //Swift.print("maxValue: " + "\(maxValue)")
        //Swift.print("vValues: " + "\(vValues)")
        for i in 0..<vValues.count{//calc the graphPoints:
            var p = CGPoint()
            let value:CGFloat = vValues[i]
            let ratio:CGFloat = value/maxValue/*a value between 0-1*/
            //ratio = ratio.isNaN ? 0 : ratio//cases can be
            //Swift.print("ratio: " + "\(ratio)")
            let dist:CGFloat = h*ratio
            //Swift.print("dist: " + "\(dist)")
            p.x = x + (i * spacing.width)
            p.y = y - dist
            points.append(p)
        }
        //Swift.print("points: " + "\(points)")
        return points
    }
    /**
     * Generates value indicators that match up with the (data set)
     */
    static func verticalIndicators(_ vCount:Int,_ maxValue:CGFloat)->[String]{
        //Swift.print("verticalIndicators")
        var strings:[String] = []
        for i in (0..<vCount).reversed() {//swift 3 update
            //Swift.print("i: " + "\(i)")
            var num:CGFloat = (maxValue/(vCount.cgFloat-1))*i
            //Swift.print("num: " + "\(num)")
            num = num < 1 ? CGFloatModifier.toFixed(num, 2) : round(num)
            //Swift.print("after round num: " + "\(num)")
            let str:String = num.string
            //Swift.print("str: " + "\(str)")
            strings.append(str)
            //Tip: use skin.getWidth() if you need to align Element items with Align
        }
        return strings
    }
    /**
     *
     */
    static func maxValue(_ vValues:[CGFloat]) -> CGFloat{
        var maxValue:CGFloat = NumberParser.max(vValues)//you need to map these and ceil them. as you need int values!?!?
        //Swift.print("maxValue: " + "\(maxValue)")
        
        //Swift.print("itemYSpace: " + "\(itemYSpace)")
        if(CGFloatAsserter.odd(maxValue) || maxValue == 0){
            maxValue += 1//We need even values when we divide later
        }
        return maxValue
    }
}
