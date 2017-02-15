import Cocoa
@testable import Utils

protocol IList:IElement {
    //func getItemsHeight()->CGFloat
    //func setSize(width : CGFloat, height : CGFloat)
    //var height : CGFloat{get}  //TODO:you can extend IElement
    var itemHeight:CGFloat{get}
    var dataProvider:DataProvider{get}
    var lableContainer:Container? {get}
}
/**
 * TODO: Continue adding methods here
 */
extension IList{
    /*Parsers*/
    var selected:ISelectable?{return ListParser.selected(self)}/*Convenience*/
    var selectedIndex:Int{return ListParser.selectedIndex(self)}/*Convenience*/
    var itemsHeight:CGFloat {return ListParser.itemsHeight(self)}/*Convenience*/
    /*Modifiers*/
    func selectAt(_ index:Int){/*convenience*/
        ListModifier.selectAt(self, index)
    }
    var dp:DataProvider {return self.dataProvider}/*convenience*/
}
