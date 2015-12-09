import Foundation

class DecoratorAsserter {
    /**
     * Asserts if @param decoratable has a Decorator instance of "Class type" @param classType
     */
    class func hasDecoratable(decoratable:IGraphicDecoratable,_ classType:AnyClass)-> Bool {
        //Swift.print("DecoratorAsserter.hasDecoratable()")
        return DecoratorParser.decoratable(decoratable, classType) != nil;
    }
}
