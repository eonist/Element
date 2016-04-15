import Cocoa

class Column:Element{
    var title:String
    var dataProvider:DataProvider
    var header:CheckTextButton?
    var list:List?
    init(_ width:CGFloat, _ height:CGFloat, _ title:String, _ dataProvider:DataProvider, _ parent:IElement? = nil, _ id:String = "") {
        self.title = title
        self.dataProvider = dataProvider
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        header = addSubView(CheckTextButton(NaN, NaN,title,false,self,"header"))
        list = addSubView(List(width, height /*<--these should be NaN*/,NaN, dataProvider, self))
    }
    //----------------------------------
    //  event handlers
    //----------------------------------
    private func onHeaderCheck(event:CheckEvent){
        Swift.print("Column.onHeaderCheck");
        super.onEvent(event)//forwards the event
    }
    private func onListSelect(event : ListEvent)  {
        Swift.print("Column.onListSelect");
        let rowIndex:Int = ListParser.index(list!, event.selected as! NSView)
        Swift.print("rowIndex: " + "\(rowIndex)")
		super.onEvent(ColumnEvent(ColumnEvent.select,rowIndex,true));
    }
    override func onEvent(event: Event) {
        if(event.type == CheckEvent.check && event.origin === header){onHeaderCheck(event as! CheckEvent)}
        if(event.type == ListEvent.select && event.origin === list){onListSelect(event as! ListEvent)}
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
