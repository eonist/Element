import Foundation
@testable import Utils
@testable import Element

class TreeList3Item:SelectCheckBoxButton/*,ITreeListItem*/ {
    override func getClassType() -> String {
        return "\(TreeList3Item.self)"
    }
    /*override func mouseOver(_ event:MouseEvent) {
     super.mouseOver(event)
     Swift.print("TreeList3Item.getSkinState(): " + "\(getSkinState())")
     }*/
}
