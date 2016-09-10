import Foundation

class StyleManagerUtils{
    static func hashStyle(style:IStyle){
        //when you add styles:
        if(style.selectors.last!.element != ""){
            if let styles = stylesByElement[style.selectors.lastItem.element]{
                styles.append(style)
            }else{
                stylesByElement[style.selectors.lastItem.element] = [style]
            }
        }
        if(style.selectors.lastItem.id != ""){
            
        }
        if(style.selectors.lastItem.classIds.count > 0){
            
        }
        if(style.selectors.lastItem.states.count > 0){
            
        }    
    }
}

