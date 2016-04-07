import Foundation

class ColumnParser {
    /**
     * Returns the indices in a a spessific sort order
     */
    public static function sortOrder(column:Column,options:*):Array {
    var list:IList = column.list;
    var sortList:Array = [];
    var children:Array = DisplayObjectParser.children(list.lableContainer);
    for each (var selectTextButton : SelectTextButton in children) sortList.push({name:selectTextButton.name,text:selectTextButton.text.getText() != "" ? selectTextButton.text.getText() : "~",index:list.lableContainer.getChildIndex(selectTextButton)});
    sortList.sortOn(["text"],options);
    var indices:Array = [];
    for (var i : int = 0; i < sortList.length; i++) indices.push(sortList[i]["index"]);
    return indices;
    }
}
