import Foundation

extension SelectGroup {
    //Continue here, also make sure both selectgroups works in the ToolBarWin
    func selected(selectables:Array<ISelectable>) -> ISelectable? {return SelectParser.selected(self.selectables)}
    
}
