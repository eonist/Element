import Cocoa
@testable import Utils

protocol IList2:Displaceable {
    //func getItemsHeight()->CGFloat
    //func setSize(width : CGFloat, height : CGFloat)
    //var height : CGFloat{get}  //TODO:you can extend IElement
    /*var itemHeight:CGFloat{get}*/
    /*var lableContainer:Container? {get}*/
    var dataProvider:DataProvider{get}
}
/**
 * TODO: Continue adding methods here
 */
extension IList2{
    /*Parsers*/
    var selected:ISelectable?{fatalError("not implemented yet")}/*Convenience*/
    var selectedIndex:Int{return 0}/*Convenience*/
    //var itemsHeight:CGFloat {fatalError("not implemented yet")}/*Convenience*/
    /*Modifiers*/
    func selectAt(_ index:Int){/*convenience*/
        fatalError("not implemented yet")
    }
    var dp:DataProvider {return self.dataProvider}/*convenience*/
    var itemsHeight: CGFloat {return dp.count * itemHeight}//👈 new
}
