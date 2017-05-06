import Foundation
@testable import Utils

class TreeList3Item:SelectCheckBoxButton/*,ITreeListItem*/ {
    override func getClassType() -> String {
        return "\(TreeList3Item.self)"
    }
    override func mouseOver(_ event: MouseEvent) {
        //mouseOver
    }
    override func mouseOut(_ event: MouseEvent) {
        //mouseOut
    }

}
