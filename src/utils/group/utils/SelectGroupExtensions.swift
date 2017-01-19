import Cocoa
@testable import Utils

extension SelectGroup {
    /*Parsing*/
    func getSelected() -> ISelectable? {return SelectParser.selected(self.selectables)}/*Convenience*/
    func index(_ selectable:ISelectable)->Int{return SelectGroupParser.index(self, selectable)}/*Convenience*/
    var indexOfSelected:Int{return SelectGroupParser.indexOfSelected(self)}/*Convenience*/
    func selectableAt(_ index:Int)->ISelectable?{return SelectGroupParser.selectableAt(self, index)}/*Convenience*/
    /*Modifiers*/
    func selectedAt(_ index:Int){SelectGroupModifier.selectedAt(self, index)}/*Convenience*/
    func select(_ selectable:ISelectable){SelectGroupModifier.select(self, selectable)}/*Convenience*/
    func removeSelectable(_ item:ISelectable)->ISelectable? {return SelectGroupModifier.removeSelectable(self, item)}/*Convenience*/
}
