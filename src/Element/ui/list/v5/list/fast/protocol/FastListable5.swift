import Foundation

protocol FastListable5:Progressable5,Listable5{
    var selectedIdx:Int? {get set}/*TODO: ⚠️️ rename to just selected?*/
    var pool:[FastListItem] {get set}/*Stores UI item and Absolute Index*/
    func reUse(_ listItem:FastListItem)
    func createItem(_ index:Int) -> Element
    var inActive:[FastListItem] {get set}
}

