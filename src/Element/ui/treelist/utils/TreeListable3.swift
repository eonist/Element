import Foundation
@testable import Element
@testable import Utils

protocol TreeListable3:FastListable3 {//possibly rename to TreeListKind
    var treeDP: TreeDP {get}
}
