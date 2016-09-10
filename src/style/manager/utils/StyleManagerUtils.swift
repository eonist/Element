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
        if(style.selectors.last!.classIds.count > 0){
            if (stylesByElement[style.selectors.last!.id] != nil){
                stylesByElement[style.selectors.last!.id]!.append(style)
            }else{
                stylesByElement[style.selectors.last!.id] = [style]
            }
        }
        if(style.selectors.last!.states.count > 0){
            
        }    
    }
}

