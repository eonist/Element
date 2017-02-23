import Foundation

protocol ITreeListItem:ITreeList{
    func open()
    func close()
    var checkBox:CheckBox?
    func setChecked(_ isChecked:Bool)
    func getChecked() -> Bool
}
