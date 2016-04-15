import Cocoa

class ColumnParser {
    /**
     * Returns the indices in a a spessific sort order
     */
    class func sortOrder(column:Column,_options:AnyObject)->Array<Int> {
        let list:IList = column.list!
        let children:Array<SelectTextButton> = NSViewParser.childrenOfType(list.lableContainer!, SelectTextButton.self)
        var sortList:Array<[String:AnyObject]> = []
        for selectTextButton  in children {
            sortList.append(["text":selectTextButton.text!.getText() != "" ? selectTextButton.text!.getText() : "~","index":list.lableContainer!.indexOf(selectTextButton)])
        }
        
        sortList.sortInPlace({$0["text"] as! String > $1["text"] as! String})
        
        /*
        sortList.sortOn(["text"],options)
        
        //
        
        var indices:Array<Int> = []
        for (var i : Int = 0; i < sortList.count; i++) {indices.append(sortList[i]["index"])}
        return indices
        */
        
        //Continue here: fix the above
        
        //
        return [0]
    }
}
