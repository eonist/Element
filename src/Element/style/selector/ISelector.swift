/**
 * TODO: ⚠️️ Remember to check out NSHipster CSS example
 */
typealias ISelector = SelectorKind
protocol ISelector{
    var element:String{get}
    var classIds:[String]{get}
    var id:String{get}
    var states:[String]{get}
}
