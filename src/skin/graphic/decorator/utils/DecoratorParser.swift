import Foundation

class DecoratorParser {
    /**
     * Returns a Decorator instance from @param decoratable by Class type @param classType if it exists, if it doesnt it returns null
     * NOTE: parses throught the hirarchy of decorators to see if there is a match, then returns this match, 
     */
    class func decoratable(decoratable:IGraphicDecoratable,_ theClassType:AnyClass)->IGraphicDecoratable? {
        //Swift.print("DecoratorParser.decoratable() theClassType: " + String(theClassType))
        //Swift.print(String(decoratable.dynamicType))
        if(Utils.isInstanceOfClass(decoratable, theClassType)) {return decoratable}
        var current:IGraphicDecoratable = decoratable
        while(current.getDecoratable() !== current) {
            //Swift.print(String(current.getDecoratable().dynamicType))
            if(Utils.isInstanceOfClass(current.getDecoratable(), theClassType)) {return current.getDecoratable()}
            current = current.getDecoratable()
        }
        return nil
    }
}
private class Utils{
    /**
     * NOTE: this is a naive way of asserting if an instance of a protocol is a class
     * NOTE: However this method supports...
     */
    class func isInstanceOfClass(instanceType:IGraphicDecoratable,_ theClassType:AnyClass)->Bool{
        //Swift.print(String(instanceType.dynamicType))
        //Swift.print(String(theClassType))
        return String(theClassType) == String(instanceType.dynamicType)
    }
}