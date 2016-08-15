import Cocoa

extension SelectGroup {
    /*Parsing*/
    func getSelected() -> ISelectable? {return SelectParser.selected(self.selectables)}/*Convenience*/
    func index(selectable:ISelectable)->Int{return SelectGroupParser.index(self, selectable)}/*Convenience*/
    var indexOfSelected:Int{return SelectGroupParser.indexOfSelected(self)}/*Convenience*/
    func selectableAt(index:Int)->ISelectable?{return SelectGroupParser.selectableAt(self, index)}/*Convenience*/
    /*Modifiers*/
    func selectedAt(index:Int){SelectGroupModifier.selectedAt(self, index)}/*Convenience*/
    func select(selectable:ISelectable){SelectGroupModifier.select(self, selectable)}/*Convenience*/
    func removeSelectable(item:ISelectable)->ISelectable? {return SelectGroupModifier.removeSelectable(self, item)}/*Convenience*/
}
