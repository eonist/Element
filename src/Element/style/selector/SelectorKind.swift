/**
 * TODO: ⚠️️ Remember to check out NSHipster CSS example
 */
typealias ISelector = SelectorKind
protocol SelectorKind{
    var element:String{get}
    var classIds:[String]{get}
    var id:String{get}
    var states:[String]{get}
}
