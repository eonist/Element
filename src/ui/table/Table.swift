import Foundation
/**
 * NOTE: this is a basic Table, its not fully featured yet
 * TODO: Obviously more stuff need to be added To TableModifier and TableParser  this is just the basic design, we need to connect the database to update the table on changes to the database etc
 * TODO: create ScrollTable.as in the future, consider how columns will work though?, since they containe a List instance which is has its own mask and height, how do we begin to scroll all of them in tandem? do we redesign column to contain selectButtons and remove list? Think  it through and draw it out on paper
 * TODO: Table header needs to be a SelectableCheckButton, since it needs both be selectable and checkable
 */
class Table:Element{
    var node:Node
    var columns:Array<Column> = []
    var columnContainer:Container?
    init(_ width:CGFloat, _ height:CGFloat, _ node:Node, _ parent:IElement? = nil, _ id:String = "") {
        self.node = node
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        columnContainer = addSubView(Container(width,height,self,"column"))
        for i in 0..<node.xml.children!.count{//<--swift 3 for loop
            let child:NSXMLNode = node.xml.children![i]
            let itemData = XMLParser.attribs(child as! NSXMLElement)
            if(itemData["hasChildren"] == "true" || child.children!.count > 0) {
                columns.append(columnContainer!.addSubView(Column(100,height,/*<--these should be NaN*/itemData["title"]!,DataProvider(child as? NSXMLElement),columnContainer,String(i))))
            }/*we add the columns index to the id so we can set individual css properties to each column*/
        }
    }
    /**
     * When a header of a column is clicked then sort that column and sibling columns to the same sort order
     * TODO: Research how UNIQUE sort works see legacy code help docs or google, it might be faster!?!?
     */
    private func onColumnHeaderCheck(event:CheckEvent) {
        Swift.print("Table.onColumnHeaderCheck()" + "\(event.origin)")
        if(event.origin is Column) {//ClassAsserter.ofType(event.origin, Column.self)
            let indices:Array<Int> = ColumnParser.sortOrder(event.origin as! Column, event.isChecked)// :TODO: maybe we can add the NUMERIC sort so that if a text starts with a number etc
            for column in columns {
                DepthModifier.sortByIndices(column.list!.lableContainer!, indices)
                ElementModifier.floatChildren(column.list!.lableContainer!)
            }
        }
    }
    /**
     * Selects the other rows to the current selected row index of the current pressed column item
     */
    private func onColumnSelect(event : ColumnEvent) {
        Swift.print("Tavle.onColumnSelect() event.origin: " + "\(event)")
        TableModifier.selectRow(self,event.rowIndex!,event.origin as? Column)
    }
    override func onEvent(event: Event) {
        if(event.type == CheckEvent.check) {onColumnHeaderCheck(event as! CheckEvent)}
        if(event.type == ColumnEvent.select) {onColumnSelect(event as! ColumnEvent)}
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}