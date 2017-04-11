import Cocoa
@testable import Utils

protocol IList:Containable {
    //func getItemsHeight()->CGFloat
    //func setSize(width : CGFloat, height : CGFloat)
    //var height : CGFloat{get}  //TODO:you can extend IElement
    /*var itemHeight:CGFloat{get}*/
    /*var lableContainer:Container? {get}*/
    var dataProvider:DataProvider{get}
    var dir:Dir {get}/*represents the primary dir the List flows in*/
    /*new, ⚠️️these must be here or the call defaults to containable progress and interval, this is strange ⚠️️*/
    var progress:CGFloat {get}//0-1 atBegining <-> atEnd (Stores the current progress)
    var interval:CGFloat {get}
}
