import Foundation

class LineStyleParser {
    /**
     *
     */
    class func lineCapType(lineCap:CGLineCap)->String{
        if(lineCap == CGLineCap.Butt){
            return "butt"
        }else if(lineCap == CGLineCap.Round){
            return "round"
        }else{//Square
            return "square"
        }
    }
    /**
     *
     */
    class func lineJoinType(lineJoin:CGLineJoin)->String{
        if(lineJoin == CGLineJoin.Miter){
            return "miter"
        }else if(lineJoin == CGLineJoin.Round){
            return "round"
        }else{//Bevel
            return "bevel"
        }
    }

}
