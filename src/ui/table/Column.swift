import Foundation

class Column:Element{
    private var title:String
    private var dataProvider:DataProvider
    private var header:CheckTextButton?
    private var list:List?
    init(_ width:CGFloat, _ height:CGFloat, _ title:String, _ dataProvider:DataProvider, _ parent:IElement? = nil, _ id:String = "") {
        self.title = title
        self.dataProvider = dataProvider
        super.init(width,height,parent,id)

    }
    override func resolveSkin() {
				super.resolveSkin();
				self.header = addChild(new CheckTextButton(NaN, NaN,false,false,false,_title,this,"header")) as CheckTextButton;
				self.list = addChild(new List(NaN, NaN ,NaN, _dataProvider, this)) as List;
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
