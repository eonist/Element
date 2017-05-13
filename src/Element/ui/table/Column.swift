import Cocoa
@testable import Utils

class Column:Element{
    var title:String
    var dataProvider:DataProvider
    lazy var header:CheckTextButton = { self.addSubView(CheckTextButton(NaN, NaN,self.title,false,self,"header"))}()
    lazy var list:Listable3 = {self.addSubView(List3(self.width, self.height /*<--these should be NaN*/,NaN, self.dataProvider, self))}()
    init(_ width:CGFloat, _ height:CGFloat, _ title:String, _ dataProvider:DataProvider, _ parent:IElement? = nil, _ id:String = "") {
        self.title = title
        self.dataProvider = dataProvider
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = header
        _ = list
    }
    private func onHeaderCheck(_ event:CheckEvent){
        super.onEvent(CheckEvent(CheckEvent.check,event.isChecked,self))/*Clone the event and send it, we need the origin to be Column*/
    }
    private func onListSelect(_ event:ListEvent)  {
        let rowIndex:Int = List3Parser.index(list, event.selected as! NSView)
		super.onEvent(ColumnEvent(ColumnEvent.select,rowIndex,self))
    }
    override func onEvent(_ event:Event) {
        if(event.type == CheckEvent.check && event.origin === header){onHeaderCheck(event as! CheckEvent)}
        if(event.type == ListEvent.select && event.origin === list){onListSelect(event as! ListEvent)}
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
