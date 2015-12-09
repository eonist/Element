import Foundation

class DecoratorAsserter {
        /**
         * Asserts if @param decoratable has a Decorator instance of "Class type" @param classType
         */
        class func hasDecoratable(decoratable:GraphicDecoratable,classType:Any)->Bool {
            return DecoratorParser.decoratable(decoratable, classType) != nil;
        }
    }
}
