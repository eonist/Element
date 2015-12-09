import Foundation

class DecoratorParser {
    /**
     * Returns a Decorator instance from @param decoratable by Class type @param classType if it exists, if it doesnt it returns null
     */
    class func decoratable(decoratable:IGraphicDecoratable,_ theClassType:AnyClass)->IGraphicDecoratable? {
        Swift.print("DecoratorParser.decoratable()")
        if(Utils.isInstanceOfClass(decoratable, theClassType)) {
            return decoratable;
        }
        var current:IGraphicDecoratable = decoratable;
        while(current.getDecoratable() === current) {
            if(Utils.isInstanceOfClass(decoratable, theClassType)) {
                return current.getDecoratable();
            }
            current = current.getDecoratable();
        }
        return nil;
    }
}

private class Utils{
    /**
     * NOTE: this is a naive way of asserting if an instance of a protocol is a class
     * NOTE: However this method supports
     */
    class func isInstanceOfClass(instanceType:IGraphicDecoratable,_ theClassType:AnyClass)->Bool{
        return String(theClassType) == String(instanceType)
    }
}