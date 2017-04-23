import Foundation
@testable import Utils
/**
 * NOTE: a datastorage class ("bean") parsing should be done elsewhere!
 * TODO: get rid of name?!?
 */
struct StyleCollection:IStyleCollection{
    var styles:[IStyle] = []//use obj instead?
}
