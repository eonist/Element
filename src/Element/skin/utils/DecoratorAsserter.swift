import Foundation
@testable import Utils

class DecoratorAsserter {
    /**
     * Asserts if PARAM: decoratable has a Decorator instance of "Class type" PARAM: classType
     * NOTE: parses throught the hirarchy of decorators to see if there is a match
     */
    static func hasDecoratable(_ decoratable:IGraphicDecoratable,_ classType:AnyClass) -> Bool {
        return DecoratorParser.decoratable(decoratable, classType) != nil
    }
}
