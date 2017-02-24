import Foundation

protocol ITreeListItem:ITreeList{
    func open()
    func close()
    var checkBox:CheckBox?{get set}
    func setChecked(_ isChecked:Bool)
    func getChecked() -> Bool
}
extension ITreeListItem{
    var itemHeight:CGFloat{return height}
}
