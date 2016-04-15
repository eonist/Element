import Cocoa

class ColumnParser {
    /**
     * Returns the indices in a a spessific sort order
     */
    class func sortOrder(column:Column,_options:AnyObject)->Array<Int> {
        /*
        let list:IList = column.list!
        var sortList:Array<Int> = []
        var children:Array = NSViewParser.childrenOfType(list.lableContainer!, SelectTextButton.self)
        for selectTextButton  in children {
            sortList.append({name:selectTextButton.name,text:selectTextButton.text.getText() != "" ? selectTextButton.text.getText() : "~" ,index:list.lableContainer.getChildIndex(selectTextButton)})
        }
        sortList.sortOn(["text"],options)
        var indices:Array<Int> = []
        for (var i : Int = 0; i < sortList.count; i++) {indices.append(sortList[i]["index"])}
        return indices
        */
        
        //Continue here: fix the above
        return [0]
    }
}
