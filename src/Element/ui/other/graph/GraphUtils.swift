import Foundation
@testable import Utils

class GraphUtils{
    struct GraphConfig{
        var size:CGSize, position:CGPoint, spacing:CGSize,  vValues:[CGFloat],  maxValue:CGFloat,  leftMargin:CGFloat,  topMargin:CGFloat
    }
    /**
     * New
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     */
    static func points2(rect:CGRect, spacing:CGSize,  vValues:[CGFloat]) -> [CGPoint]{
        guard let maxValue:CGFloat = vValues.max() else {fatalError("err: \(vValues.count)")}/*Finds the largest number in among vValues*/
        let x:CGFloat = rect.x//spacing.width
        let y:CGFloat = rect.height - (rect.y)//the y point to start from, basically bottom
        let h:CGFloat = rect.height - (rect.y)//the height to work within
        return vValues.indices.reduce([]) { (acc:[CGPoint],i:Int) in
            let p:CGPoint = {
                let value:CGFloat = vValues[i]
                let ratio:CGFloat = value/maxValue/*a value between 0-1*/
                //ratio = ratio.isNaN ? 0 : ratio//cases can be
                //Swift.print("ratio: " + "\(ratio)")
                let dist:CGFloat = h*ratio
                let x:CGFloat = x + (i * spacing.width)
                let y:CGFloat = y - dist
                let _y:CGFloat = y.isNaN ? rect.height - rect.y : y//⚠️️ quick fix, for when vValue is 0
                return CGPoint(x,_y)
            }()
            return acc + [p]
        }
    }
    /**
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     * NOTE: ⚠️️ Modulates the vValues to fit a predefined rect.
     * PARAM: vValues: y-axis values
     * PARAM: maxValue: (the max value among the y-axis values)
     * PARAM: spacing: (itemSpacing for both axis)
     * PARAM: position: Supposedly it's the topLeft anchor of the graph (⚠️️ out of service)
     * PARAM: size: represents the width and height of the graph
     */
    static func points(config:GraphConfig) -> [CGPoint]{
        var points:[CGPoint] = []
        let x:CGFloat = /*position.x*/ config.leftMargin//spacing.width
        let y:CGFloat = /*position.y +*/ config.size.height - (config.topMargin)//the y point to start from, basically bottom
        let h:CGFloat = config.size.height - (config.topMargin*2)//the height to work within
        for i in 0..<config.vValues.count{//calc the graphPoints://TODO: ⚠️️ Use functional programming
            var p = CGPoint()
            let value:CGFloat = config.vValues[i]
            let ratio:CGFloat = value/config.maxValue/*a value between 0-1*/
            //ratio = ratio.isNaN ? 0 : ratio//cases can be
            //Swift.print("ratio: " + "\(ratio)")
            let dist:CGFloat = h*ratio
            p.x = x + (i * config.spacing.width)
            p.y = y - dist
            p.y = p.y.isNaN ? config.size.height - config.topMargin : p.y//⚠️️ quick fix, for when vValue is 0
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
            let num:CGFloat = (maxValue/(vCount.cgFloat-1))*i
            let roundedNum:CGFloat = num < 1 ? CGFloatModifier.toFixed(num, 2) : round(num)
            let str:String = roundedNum.string
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
    /**
     * Generates random y-axis values (used for debug purpouses)
     */
    static func randomVerticalValues(count:Int,min:Int,max:Int) -> [CGFloat]{
        /*var values:[CGFloat] = []/*commits in a single day*/
         for _ in (0..<7).reversed() {
         let val:CGFloat = IntParser.random(4, 24).cgFloat/*generate vValues via random, as we use faux data for now*/
         values.append(val)
         }
         return values*/
        return (0..<count).map{_ in IntParser.random(min, max).cgFloat}
    }
}
