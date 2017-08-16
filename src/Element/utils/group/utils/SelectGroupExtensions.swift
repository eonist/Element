import Cocoa
@testable import Utils

extension SelectGroup {
    /*Parsing*/
    func getSelected() -> Selectable? {return SelectParser.selected(self.selectables)}/*Convenience*/
    func index(_ selectable:Selectable)->Int{return SelectGroupParser.index(self, selectable)}/*Convenience*/
    var indexOfSelected:Int{return SelectGroupParser.indexOfSelected(self)}/*Convenience*/
    func selectableAt(_ index:Int)->Selectable?{return SelectGroupParser.selectableAt(self, index)}/*Convenience*/
    /*Modifiers*/
    func selectedAt(_ index:Int){SelectGroupModifier.select(self, index)}/*Convenience*///TODO: Rename to select?
    func select(_ selectable:Selectable){SelectGroupModifier.select(self, selectable)}/*Convenience*/
    func removeSelectable(_ item:Selectable)->Selectable? {return SelectGroupModifier.removeSelectable(self, item)}/*Convenience*/
}
