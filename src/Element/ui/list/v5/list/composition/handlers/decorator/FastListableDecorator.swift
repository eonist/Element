import Cocoa
@testable import Utils
//rename to ....Accessor
protocol FastListableDecorator:ProgressableDecorator,FastListable5 {}

extension FastListableDecorator{
    var selectedIdx: Int? {get{return fastListable.selectedIdx} set{fastListable.selectedIdx = newValue}}
    var pool: [FastListItem] {get{return fastListable.pool} set{fastListable.pool = newValue}}
    var inActive: [FastListItem] {get{return fastListable.inActive} set{fastListable.inActive = newValue}}
    //List
    var dp: DataProvider {get{return fastListable.dp}}
    var dir: Dir {get{return fastListable.dir}}
    func reUse(_ listItem: FastListItem) {
        fastListable.reUse(listItem)
    }
    func createItem(_ index: Int) -> Element {
        return  fastListable.createItem(index)
    }
    //override scroll I think?, make sure fastlist gets it's setProgress 🏀
    
    var fastListable:FastListable5 {return progressable as! FastListable5}
}
