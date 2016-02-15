import Foundation

protocol IList {
    func getItemsHeight():Number
    func setSize(width : Number, height : Number) : void
    func getClassType() : String
    func get itemHeight() : Number
    func get height() : Number
    //----------------------------------
    //  getters / setters
    //----------------------------------
    var dataProvider:DataProvider{get}
    var lableContainer : {get}
}
