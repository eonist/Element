import Foundation

class DecoratorParser {
    /**
     * Returns a Decorator instance from @param decoratable by Class type @param classType if it exists, if it doesnt it returns null
     */
    class func decoratable(decoratable:IGraphicDecoratable,_ theClassType:AnyClass)->IGraphicDecoratable? {
        
        
        if(Utils.isInstanceOfClass(decoratable, theClassType)) {
            return decoratable;
        }
        var current:IGraphicDecoratable = decoratable;
        
        
        //continue here, figure out how you can check equality between 2 protocol references or make the IGraphicDecoratable equatable on an instance level or alike. 
        
        while(current.decoratable === current) {
            if(Utils.isInstanceOfClass(decoratable, theClassType)) {
                return current.decoratable;
            }
            current = current.decoratable;
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