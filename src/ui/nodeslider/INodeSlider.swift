import Foundation

protocol INodeSlider {
    var selected:ISelectable? {get}
    var startNode:SelectButton? {get}
    var endNode:SelectButton? {get}
    var selectGroup:SelectGroup? {get}
    var startProgress:CGFloat {get}
    var endProgress:CGFloat {get}
}
