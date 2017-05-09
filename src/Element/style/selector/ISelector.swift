/**
 * TODO: ⚠️️ Rename to SelectorKind (Also remember to check out NSHipster CSS example)
 */
protocol ISelector{
    var element:String{get}
    var classIds:[String]{get}
    var id:String{get}
    var states:[String]{get}
}
