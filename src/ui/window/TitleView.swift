import Foundation


//Continue here:
//1. Make TitleView which should go next to CustomView and extend it
//2. Install the css required to style TitleView in the ElCapitan css framework. (Currently they are Inline)

//1. center the text to 50% of its parent (the parrent must be 100%)
//2. you offset the  Text element by half its width (100px) in the negative x dir (the text should be centered, and 200px wide)

//Continue here: You need to figure out how to center align things. Make a box test. see old notes
//then you need to figure out how to Align something to the left and centered and to the right (see css tricks)
//then you need to apply it to the bellow (You could also possiblly add it to the Window class, or add TitleWindw to the fold)


class TitleView:CustomView{
    var textArea:TextArea?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = "") {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        var css:String = ""
        css += "TextArea#winTitle{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "width:100%;"
        css +=     "offset:75px,0px;"
        css +=     "fill-alpha:0;"
        //css +=     "fill:yellow;"
        css +=     "line-alpha:0;"
        css +=     "line-thickness:0px;"
        css +=     "background:true;"
        css += "}"
        css += "TextArea#winTitle Text{"
        css +=     "width:100%;"
        css +=     "height:16px;"
        css +=     "offset:-75px,0px;"//<- set the width of the text to 100% and the offset to -the width of the titlebarIconContainer
        css +=     "scrollable:false;"
        css +=     "multiline:false;"
        css +=     "wordWrap:true;"
        css +=     "align:center;"
        css +=     "margin-top:0px;"
        css +=     "margin-left:4px;"
        css +=     "font:Helvetica Neue Medium;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css +=     "selectable:false;"
        css += "}"
        StyleManager.addStyle(css)
        
        super.resolveSkin()
        
        textArea = addSubView(TextArea(NaN,24,"Title goes here",self,"winTitle"))
        textArea!.text?.isInteractive = false
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}