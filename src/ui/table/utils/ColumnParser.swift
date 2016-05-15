import Cocoa

class ColumnParser {
    /**
     * Returns the indices in a a spessific sort order
     */
    class func sortOrder(column:Column,_ isAscending:Bool)->Array<Int> {
        let list:IList = column.list!
        let children:Array<SelectTextButton> = NSViewParser.childrenOfType(list.lableContainer!, SelectTextButton.self)
        var sortList:Array<[String:AnyObject]> = []
        for selectTextButton  in children {
            sortList.append(["text":selectTextButton.text!.getText() != "" ? selectTextButton.text!.getText() : "~","index":list.lableContainer!.indexOf(selectTextButton)])
        }
        if(isAscending){
            sortList.sortInPlace({$0["text"] as! String > $1["text"] as! String})
        }else{
            sortList.sortInPlace({$1["text"] as! String > $0["text"] as! String})
        }
        var indices:Array<Int> = []
        for (var i : Int = 0; i < sortList.count; i++) {indices.append(sortList[i]["index"] as! Int)}
        return indices
    }
}