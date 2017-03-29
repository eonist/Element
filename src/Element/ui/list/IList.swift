import Cocoa
@testable import Utils

protocol IList:Containable {
    //func getItemsHeight()->CGFloat
    //func setSize(width : CGFloat, height : CGFloat)
    //var height : CGFloat{get}  //TODO:you can extend IElement
    /*var itemHeight:CGFloat{get}*/
    /*var lableContainer:Container? {get}*/
    var dataProvider:DataProvider{get}
    var dir:Dir
}
