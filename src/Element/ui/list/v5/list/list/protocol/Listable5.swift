import Foundation
@testable import Utils

protocol Listable5:Containable5 {//extending Containable3 is new
    var dp:DataProvider {get}
    var dir:Dir {get}//the "primary" direction the list scroll in. the secondary direction is the opposite
    var itemSize:CGSize{get}
}

