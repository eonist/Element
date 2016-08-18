import Cocoa

protocol IList {
    //func getItemsHeight()->CGFloat
    //func setSize(width : CGFloat, height : CGFloat)
    //var height : CGFloat{get}  //TODO:you can extend IElement
    var itemHeight : CGFloat{get}
    var dataProvider:DataProvider{get}
    var lableContainer :Container? {get}
}
/**
 * TODO: Continue adding methods here
 */
extension IList{
    /*Parsers*/
    func selected() -> ISelectable?{
        return ListParser.selected(self)
    }
    /*Modifiers*/
    func selectAt(index:Int){/*convenience*/
        ListModifier.selectAt(self, index)
    }
}