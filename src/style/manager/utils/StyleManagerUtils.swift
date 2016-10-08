import Foundation

class StyleManagerUtils{
    static var stylesByElement:Dictionary<String,[IStyle]> = [:]
    static var stylesByID:Dictionary<String,[IStyle]> = [:]
    static var stylesByClassId:Dictionary<String,[IStyle]> = [:]
    static var stylesByState:Dictionary<String,[IStyle]> = [:]
    /**
     * We hash the tail of the style selectors
     * TODO: Use if let to make this method smaller
     */
    static func hashStyle(style:IStyle){
        //when you add styles:
        if(style.selectors.last!.element != ""){
            if var lastElement = stylesByElement[style.selectors.last!.element]{
                lastElement.append(style)
            }else{
                stylesByElement[style.selectors.last!.element] = [style]
            }
        }
        if(style.selectors.last!.id != ""){
            if var lasId = stylesByID[style.selectors.last!.id]{
                lasId.append(style)
            }else{
                stylesByID[style.selectors.last!.id] = [style]
            }
        }
        if(style.selectors.last!.classIds.count > 0){//temp solution, you need to flatten the classIds somehow, or test individual etc
            if (stylesByClassId[style.selectors.last!.classIds.first!] != nil){
                stylesByClassId[style.selectors.last!.classIds.first!]!.append(style)
            }else{
                stylesByClassId[style.selectors.last!.classIds.first!] = [style]
            }
        }
        if(style.selectors.last!.states.count > 0){//temp solution, you need to flatten the states somehow, or test individual etc
            if (stylesByState[style.selectors.last!.states.first!] != nil){
                stylesByState[style.selectors.last!.states.first!]!.append(style)
            }else{
                stylesByState[style.selectors.last!.states.first!] = [style]
            }
        }    
    }
}