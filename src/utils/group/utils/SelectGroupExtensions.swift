import Cocoa

extension SelectGroup {
    func selected(selectables:Array<ISelectable>) -> ISelectable? {return SelectParser.selected(self.selectables)}
    func selected(view:NSView) -> ISelectable? {return SelectParser.selected(view)}
    func index(selectable:ISelectable)->Int{return SelectGroupParser.index(self, selectable)}
}
