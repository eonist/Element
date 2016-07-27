import Cocoa

extension SelectGroup {
    func selected(selectables:Array<ISelectable>) -> ISelectable? {return SelectParser.selected(self.selectables)}//Convenience
    func index(selectable:ISelectable)->Int{return SelectGroupParser.index(self, selectable)}//Convenience
    func indexOfSelected(selectGroup:SelectGroup)->Int{return SelectGroupParser.indexOfSelected(self)}//Convenience
    func selectableAt(selectGroup:SelectGroup,_ index:Int)->ISelectable?{return SelectGroupParser.selectableAt(self, index)}//Convenience
}
