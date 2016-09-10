import Foundation

class StyleManagerUtils{
    static var stylesByElement:Dictionary<String,[IStyle]> = [:]
    /**
     * We hash the tail of the style selectors
     */
    static func hashStyle(style:IStyle){
        //when you add styles:
        if(style.selectors.last!.element != ""){
            if (stylesByElement[style.selectors.last!.element] != nil){
                stylesByElement[style.selectors.last!.element]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.element] = [style]
            }
        }
        if(style.selectors.last!.id != ""){
            if (stylesByElement[style.selectors.last!.id] != nil){
                stylesByElement[style.selectors.last!.id]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.id] = [style]
            }
        }
        if(style.selectors.last!.classIds.count > 0){//temp solution, you need to flatten the classIds somehow, or test individual etc
            if (stylesByElement[style.selectors.last!.classIds.first!] != nil){
                stylesByElement[style.selectors.last!.classIds.first!]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.classIds.first!] = [style]
            }
        }
        if(style.selectors.last!.states.count > 0){//temp solution, you need to flatten the states somehow, or test individual etc
            if (stylesByElement[style.selectors.last!.states.first!] != nil){
                stylesByElement[style.selectors.last!.states.first!]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.states.first!] = [style]
            }
        }    
    }
}